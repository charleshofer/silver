grammar silver:definition:core;

import silver:definition:env;

import silver:definition:regex;  -- soley for Terms. TODO : fix?

-- values

-- reference a value
synthesized attribute refDispatcher :: Production(Expr ::= Decorated QName) occurs on DclInfo;
-- define a value in a semantic block
synthesized attribute defDispatcher :: Production(ProductionStmt ::= Decorated QName  Equal_t  Expr) occurs on DclInfo;
-- define attributes on a value in a semantic block
synthesized attribute defLHSDispatcher :: Production (DefLHS ::= Decorated QName) occurs on DclInfo;

-- attributes
-- access attribute on a value
synthesized attribute attrAccessDispatcher :: Production (Expr ::= Decorated Expr Dot_t Decorated QName) occurs on DclInfo;
-- define an attribute on a value
synthesized attribute attrDefDispatcher :: Production (ProductionStmt ::= DefLHS Dot_t Decorated QName Equal_t Expr) occurs on DclInfo;


{- Algorithms:

  Expr.QName     accessDispatcher on Expr.typerep.  NT will dispatch on QName.attrAccessDispatcher.
  
  Expr(Exprs)    applicationDispatcher on Expr.typerep.
  
  QName          refDispatcher on QName
  
  QName = Expr   defDispatcher on QName
  
  DefLHS . QName = Expr   attrDefDispatcher. Give isInherited/isSynthesized to DefLHS (which is gotten via defLHSDispatcher)
  
-}

aspect production defaultDcl
top::DclInfo ::=
{
  -- again, blank.
  
  -- all values must provide refDispatcher, defDispatcher, dehLHSDispatcher.
  -- all attributes must provide attrAccessDispatcher, attrDefDispatcher.
}

-- -- non-interface values
aspect production childDcl
top::DclInfo ::= sg::String sl::Decorated Location fn::String ty::Decorated TypeRep
{
  top.refDispatcher = childReference;
  top.defDispatcher = errorValueDef; -- TODO: we should be smarted about error messages, and mention its a child
  top.defLHSDispatcher = childDefLHS;
}
aspect production lhsDcl
top::DclInfo ::= sg::String sl::Decorated Location fn::String ty::Decorated TypeRep
{
  top.refDispatcher = lhsReference;
  top.defDispatcher = errorValueDef; -- TODO: be smarter about the error message
  top.defLHSDispatcher = lhsDefLHS;
}
aspect production localDcl
top::DclInfo ::= sg::String sl::Decorated Location fn::String ty::Decorated TypeRep
{
  top.refDispatcher = localReference;
  top.defDispatcher = localValueDef;
  top.defLHSDispatcher = localDefLHS;
}


-- -- interface values
aspect production prodDcl
top::DclInfo ::= sg::String sl::Decorated Location ns::Decorated NamedSignature
{
  top.refDispatcher = productionReference;
  top.defDispatcher = errorValueDef;
  top.defLHSDispatcher = errorDefLHS;
}
aspect production funDcl
top::DclInfo ::= sg::String sl::Decorated Location ns::Decorated NamedSignature
{
  top.refDispatcher = functionReference;
  top.defDispatcher = errorValueDef;
  top.defLHSDispatcher = errorDefLHS;
}

-- -- interface types
aspect production ntDcl
top::DclInfo ::= sg::String sl::Decorated Location fn::String
{
}
aspect production termDcl
top::DclInfo ::= sg::String sl::Decorated Location fn::String regex::Decorated Regex_R
{
}

-- -- interface Attributes
aspect production synDcl
top::DclInfo ::= sg::String sl::Decorated Location fn::String ty::Decorated TypeRep
{
  top.attrAccessDispatcher = synDNTAccessDispatcher;
  top.attrDefDispatcher = synthesizedAttributeDef;
}
aspect production inhDcl
top::DclInfo ::= sg::String sl::Decorated Location fn::String ty::Decorated TypeRep
{
  top.attrAccessDispatcher = inhDNTAccessDispatcher;
  top.attrDefDispatcher = inheritedAttributeDef;
}

-- -- interface Production attr (values)
aspect production paDcl
top::DclInfo ::= sg::String sl::Decorated Location fn::String dcl::DclInfo
{
}
aspect production forwardDcl
top::DclInfo ::= sg::String sl::Decorated Location ty::Decorated TypeRep
{
  top.refDispatcher = forwardReference;
  top.defDispatcher = errorValueDef; -- TODO: better error message
  top.defLHSDispatcher = forwardDefLHS;
}

-- -- interface other
aspect production occursDcl
top::DclInfo ::= sg::String sl::Decorated Location fnnt::String fnat::String
{
}
