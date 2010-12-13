grammar tutorials:xrobots:terminals ;

terminal LT_t     '<'   precedence = 8 ;
terminal GT_t     '>'   precedence = 8 ;
terminal EqEq_t   '=='  precedence = 8 ;

terminal And_t    '&&'  precedence = 6 ;
terminal Or_t    '||'   precedence = 6 ;
terminal Not_t    '!'   precedence = 20 ;

terminal Quest_t  '?'   precedence = 1 ;
terminal Colon_t  ':'   precedence = 1 ;
