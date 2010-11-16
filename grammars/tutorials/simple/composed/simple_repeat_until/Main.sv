grammar tutorials:simple:composed:simple_repeat_until ;

import tutorials:simple:host ;
import tutorials:simple:extensions:repeat_until ;

parser parse :: Root_c { tutorials:simple:host;
                         tutorials:simple:extensions:repeat_until; } 

function main
IO ::= args::String io_in::IO
{
 return driver(args, io_in, parse) ; 
}
