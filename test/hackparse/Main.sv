grammar hackparse;

nonterminal T;

synthesized attribute pp::String occurs on T;

terminal foo 'foo';
terminal bar 'bar';

concrete production what
top::T ::= 'foo' 'bar'
{
  top.pp = "foo and bar here";
}

parser pars::T {
  hackparse;
}

function main
IO ::= args::String i::IO
{
  -- Declare a hackparse local variable
  local attribute hp :: HackyParse;
 
  -- Call the hackparse function, casting your parser function to AnyType
  hp = hackParse( cast(pars, AnyType), args );
  
  local attribute tree :: T;
  tree = cast(hp.parseTree, T);
  
  -- query HackyParse
  return if hp.parseSuccess
         -- access the tree
         then print(tree.pp ++ "\n\n", i)
         -- access the error string
         else print(hp.parseErrors ++ "\n\n", i);
}