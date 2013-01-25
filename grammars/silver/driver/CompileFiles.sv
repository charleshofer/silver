grammar silver:driver;

{--
 - Turns a list of files that compose a grammar into a RootSpec, having compiled them.
 - @param svParser  The parser to use to contruct Roots
 - @param gpath  The path where we found the grammar. Ends in a slash/
 - @param files  The list of .sv files to read.
 - @param ioin  The io token
 - @return An ioval wrapping a GrammarParts structure containing the whole grammar.
 -}
function compileFiles
IOVal<Grammar> ::= svParser::SVParser  gpath::String  files::[String]  ioin::IO
{
  local file :: String = head(files);
  
  -- Print the path we're reading, and read the file.
  local attribute text :: IOVal<String>;
  text = readFile(gpath ++ file, print("\t[" ++ gpath ++ file ++ "]\n", ioin));

  -- This is where a .sv file actually gets parsed:
  local r :: Root = parseTreeOrDieWithoutStackTrace(svParser(text.iovalue, file));

  -- Continue parsing the rest of the files.
  production attribute recurse :: IOVal<Grammar>;
  recurse = compileFiles(svParser, gpath, tail(files), text.io);

  return if null(files) then ioval(ioin, nilGrammar())
         else ioval(recurse.io, consGrammar(grammarPart(r, file), recurse.iovalue));
}
