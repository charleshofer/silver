grammar silver:definition:core;

nonterminal Root with location, grammarName, impliedName, file, declaredName, moduleNames, importedDefs, exportedGrammars, condBuild, warnings, errors, compiledGrammars, env, globalImports, defs, pp;

nonterminal QName with name, location, grammarName, file, warnings, errors, env, defs, pp;
nonterminal Name with name, location, grammarName, file, warnings, errors, env, defs, pp;
nonterminal NameTick with name, location, grammarName, file, warnings, errors, env, defs, pp;
nonterminal NameTickTick with name, location, grammarName, file, warnings, errors, env, defs, pp;
nonterminal AGDcls with location, grammarName, file, warnings, errors, env, defs, pp, moduleNames, compiledGrammars;
nonterminal AGDcl with location, grammarName, file, warnings, errors, env, defs, pp, moduleNames, compiledGrammars;
nonterminal ProductionSignature with location, grammarName, file, inputElements, outputElement, warnings, errors, env, defs, pp;
nonterminal ProductionLHS with location, grammarName, file, outputElement, warnings, errors, env, defs, pp;
nonterminal ProductionRHS with location, grammarName, file, inputElements, warnings, errors, env, defs, pp;
nonterminal ProductionRHSElem with location, grammarName, file, inputElements, warnings, errors, env, defs, pp;
nonterminal FunctionSignature with location, grammarName, file, inputElements, outputElement, warnings, errors, env, defs, pp;
nonterminal FunctionLHS with location, grammarName, file, outputElement, warnings, errors, env, defs, pp;
nonterminal AspectProductionSignature with location, grammarName, file, inputElements, outputElement, warnings, errors, realSignature, env, defs, pp;
nonterminal AspectProductionLHS with location, grammarName, file, warnings, errors, outputElement, realSignature, env, defs, pp;
nonterminal AspectFunctionSignature with location, grammarName, file, inputElements, outputElement, warnings, errors, realSignature, env, defs, pp;
nonterminal AspectFunctionLHS with location, grammarName, file, warnings, errors, realSignature, outputElement, env, defs, pp;
nonterminal AspectRHS with location, grammarName, file, warnings, errors, inputElements, realSignature, env, defs, pp;
nonterminal AspectRHSElem with location, grammarName, file, warnings, errors, realSignature, inputElements, env, defs, pp;
nonterminal Expr with location, grammarName, file, warnings, errors, signature, expected, typerep, env, defs, pp;
nonterminal NameList with location, grammarName, file, names, warnings, errors, env, defs, pp;
nonterminal ExprInhs with location, grammarName, file, warnings, errors, signature, env, defs, pp;
nonterminal ExprInh with location, grammarName, file, warnings, errors, signature, env, defs, pp;
nonterminal ExprLHSExpr with location, grammarName, file, warnings, errors, typerep, env, defs, pp;
nonterminal Exprs with location, grammarName, file, warnings, errors, signature, expectedInputTypes, exprs, env, defs, pp;
nonterminal Module with errors, warnings, grammarName, compiledGrammars, defs;
nonterminal ImportStmt with location, grammarName, file, moduleNames, compiledGrammars, warnings, errors, importedDefs, pp;
nonterminal ImportStmts with location, grammarName, file, moduleNames, compiledGrammars, warnings, errors, importedDefs, pp;
nonterminal ModuleName with location, grammarName, file, moduleNames, compiledGrammars, warnings, errors, pp, defs;
nonterminal ModuleExpr with location, grammarName, file, moduleNames, compiledGrammars, warnings, errors, pp, defs;
nonterminal ModuleStmts with location, grammarName, file, moduleNames, importedDefs, exportedGrammars, condBuild, compiledGrammars, warnings, errors, pp;
nonterminal ModuleStmt with location, grammarName, file, moduleNames, importedDefs, exportedGrammars, condBuild, compiledGrammars, warnings, errors, pp;
nonterminal WithElems with location, grammarName, file, warnings, errors, env, defs, pp;
nonterminal WithElem with location, grammarName, file, warnings, errors, env, defs, pp;
nonterminal ProductionBody with location, grammarName, file, productionAttributes, warnings, errors, signature, env, defs, pp;
nonterminal ProductionStmts with location, grammarName, file, productionAttributes, warnings, errors, signature, env, defs, pp;
nonterminal ProductionStmt with location, grammarName, file, productionAttributes, warnings, errors, signature, env, defs, pp;
nonterminal DefLHS with location, grammarName, file, warnings, errors, signature, env, pp, typerep;
nonterminal ForwardInhs with location, grammarName, file, warnings, errors, signature, env, defs, pp;
nonterminal ForwardInh with location, grammarName, file, warnings, errors, signature, env, defs, pp;
nonterminal ForwardLHSExpr with location, grammarName, file, warnings, errors, typerep, env, defs, pp;
nonterminal GrammarDcl with location, grammarName, declaredName, file, warnings, errors, env, defs, pp;

