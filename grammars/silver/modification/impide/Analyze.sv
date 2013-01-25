-- This file defines the error demanding function that can be interfaced by IDE plugin written in Java.

--grammar silver:analysis:binding:driver;
grammar silver:modification:impide;
import silver:driver;
import silver:util:cmdargs;

import silver:definition:core;
import silver:definition:env;

-- I just copy and pasted this from BuildProcess for now...
function ideRun
IOVal<[String]> ::= args::[String]  svParser::SVParser  sviParser::SVIParser  ioin::IO
{
  local argResult :: ParseResult<Decorated CmdArgs> = parseArgs(args);
  local a :: Decorated CmdArgs = argResult.parseTree;

  -- Let's locally set up and verify the environment
  local envSH :: IOVal<String> = envVar("SILVER_HOME", ioin);
  local envGP :: IOVal<String> = envVar("GRAMMAR_PATH", envSH.io);
  local envSG :: IOVal<String> = envVar("SILVER_GEN", envGP.io);
  
  local silverHome :: String =
    endWithSlash(head(a.silverHomeOption ++ [envSH.iovalue]));
  local silverGen :: String =
    endWithSlash(head(a.genLocation ++ (if envSG.iovalue == "" then [] else [envSG.iovalue]) ++ [silverHome ++ "generated/"]));
  local grammarPath :: [String] =
    map(endWithSlash, a.searchPath ++ [silverHome ++ "grammars/"] ++ explode(":", envGP.iovalue) ++ ["."]);
  local buildGrammar :: String = head(a.buildGrammar);

  local check :: IOVal<[String]> =
    checkEnvironment(a, silverHome, silverGen, grammarPath, buildGrammar, envSG.io);
  
  -- Compile grammars. There's some tricky circular program data flow here:
  local rootStream :: IOVal<[Maybe<RootSpec>]> =
    compileGrammars(svParser, sviParser, grammarPath, silverGen, buildGrammar :: grammarStream, true, check.io);
  
  local unit :: Compilation =
    compilation(
      foldr(consGrammars, nilGrammars(), foldr(consMaybe, [], rootStream.iovalue)),
      foldr(consGrammars, nilGrammars(), foldr(consMaybe, [], reRootStream.iovalue)),
      buildGrammar, silverHome, silverGen);
  unit.config = a;
  
  -- Note that this is used above. This outputs deps, and rootStream informs it.
  local grammarStream :: [String] =
    eatGrammars(1, [buildGrammar], rootStream.iovalue, unit.grammarList);
  
  local reRootStream :: IOVal<[Maybe<RootSpec>]> =
    compileGrammars(svParser, sviParser, grammarPath, silverGen, unit.recheckGrammars, true, rootStream.io);

  return ioval(rootStream.io, getAllBindingErrors(unit.grammarList));
}

function getAllBindingErrors
[String] ::= specs::[Decorated RootSpec]
{
  return if null(specs)
         then []
         --else [foldMessages(head(specs).errors)] ++ getAllBindingErrors(tail(specs));
         else rewriteMessages(head(specs).declaredName, head(specs).errors) ++ getAllBindingErrors(tail(specs));
}

function rewriteMessages
[String] ::= declaredName::String es::[Message]
{
  return if null(es)
         then []
         else [declaredName ++ "#" ++ head(es).pp] ++ rewriteMessages(declaredName, tail(es));
}
