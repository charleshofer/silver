grammar lib:xml:test;

import lib:xml;

function main
IOVal<Integer> ::= args::[String] ioin::IO
{

  local attribute pr :: ParseResult<XMLDocument>;
  pr = parseXMLFileAsAST(head(args));
  
  return ioval( print( hackUnparse(pr), ioin ), 0);

}