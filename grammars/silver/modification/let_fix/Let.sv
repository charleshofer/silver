grammar silver:modification:let_fix;
import silver:definition:core;
import silver:definition:env;

terminal Let_kwd 'let' lexer classes {KEYWORD};
terminal In_kwd 'in' lexer classes {KEYWORD};
terminal End_kwd 'end' lexer classes {KEYWORD};

nonterminal LetAssigns with pp, file, grammarName, defs, env, signatureEnv, localsEnv, signature, errors;
nonterminal AssignExpr with pp, file, grammarName, defs, env, signatureEnv, localsEnv, signature, errors;

concrete production nameLet
top::Name ::= 'let'
{
  forwards to nameId(terminal(Id_t, "let", $1.line, $1.column));
}

--TODO remove end keyword
concrete production letp
top::Expr ::= 'let' la::LetAssigns 'in' e::Expr 'end'
{
  top.errors := la.errors ++ e.errors ;
   
  local attribute newEnv :: Decorated Env;
  newEnv = newScopeEnv(la.defs, top.env);

  local attribute newLocalsEnv :: Decorated Env;
  newLocalsEnv = newScopeEnv(la.defs, top.localsEnv);

  forwards to e'' with {
	env = newEnv;
        localsEnv = newLocalsEnv;
  };

  e.env = newEnv;
  e.localsEnv = newLocalsEnv;
}

concrete production assigns
top::LetAssigns ::= ae::AssignExpr ',' list::LetAssigns
{
  top.pp = ae.pp ++ ", " ++ list.pp;
  top.defs = appendDefs(ae.defs, list.defs);
  top.errors := ae.errors ++ list.errors;
}

concrete production assignListSingle 
top::LetAssigns ::= ae::AssignExpr
{
  top.pp = ae.pp;
  top.defs = ae.defs;
  top.errors := ae.errors;
}

concrete production assignExpr
top::AssignExpr ::= id::Name '::' t::Type '=' e::Expr
{
  production attribute fName :: String;
  fName = top.signature.fullName ++ ":l_" ++ id.name;

  top.pp = id.name ++ " = " ++ e.pp;
  top.defs = addFullNameDcl(id.name, fName, addValueDcl(fName, t.typerep, emptyDefs()));
  top.errors := e.errors ++ t.errors;

  e.expected = expected_type(t.typerep);
}
