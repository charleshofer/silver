import turing;


parser parse::Dcls {
  turing;
}

function main 
IO ::= args::String i::IO {

  local attribute file :: IOString;
  file = readFile(args, i);

  local attribute result :: Dcls;
  result = parse(file.sValue);

  local attribute extras :: IOAMachineList;
  extras = getImports(result.theImports);
  extras.ioIn = file.io;

  local attribute allMachines :: [AMachine];
  allMachines = result.machines ++ extras.machines;

  local attribute theMachine :: [AMachine];
  theMachine = findAMachine(result.startMachine, allMachines);

  local attribute t :: Decorated ATape;
  t = runMachine(head(theMachine), 
		 allMachines,
		 result.tape);
  return
	      print(t.pp ++ "\n-------------------------------------------------------------\n", 
	      print(result.tape.pp ++ "\n-------------------------------------------------------------\n", 
	      print("Results for " ++ args ++ ":\n-------------------------------------------------------------\n",
	      extras.ioOut)));
}

inherited attribute ioIn :: IO;
synthesized attribute ioOut :: IO;
nonterminal IOAMachineList with ioIn, ioOut, machines;

function getImports
IOAMachineList ::= need::[String]
{
  return getImportsHelp([::String], need);
}

abstract production getImportsHelp
top::IOAMachineList ::= seen::[String] need::[String]
{
  local attribute text :: IOString;
  text = readFile(head(need), top.ioIn);

  local attribute result :: Dcls;
  result = parse(text.sValue);

  local attribute new_seen :: [String];
  new_seen = cons(head(need), seen);

  local attribute new_need :: [String];
  new_need = makeSet(rem(result.theImports, new_seen) ++ tail(need));

  local attribute recurse :: IOAMachineList;
  recurse = getImportsHelp(new_seen, new_need);
  recurse.ioIn = text.io;

  top.ioOut = if null(need) then top.ioIn else recurse.ioOut;
  top.machines = if null(need)
	         then [::AMachine]
		 else result.machines ++ recurse.machines;
}

function makeSet
[String] ::= list::[String]
{
  local attribute recurse :: [String];
  recurse = makeSet(tail(list));

  return if null(list) then list
         else if containsString(head(list), recurse)
	      then recurse
	      else cons(head(list), recurse);
}


function containsString
Boolean ::=  str::String sl::[String]
{
  return (!null(sl)) && (str == head(sl) || containsString(str, tail(sl)));
}

function rem
[String] ::= n::[String] seen::[String]
{
  return if null(n) then [::String]
         else if containsString(head(n), seen)
	      then rem(tail(n), seen)
	      else cons(head(n), rem(tail(n), seen));
}
