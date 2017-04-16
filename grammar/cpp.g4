/**
* This a CPP Pseudo-grammar (meaning not that good). It does successfully parse
* standard C source files and identify macro names and includes; the current
* syntax tree could be extended to parse more specific. This is solely a
* demonstration of the how "modes" can be distinguished by including the
* newline character in a grammar. For whatever reason, I can actually make
* ANTLR4 "modes" to work. But entering the "preprocessor" rule is sufficiently
* considered being in the preprocessor "mode" and everything else is source
* code.
*/
grammar cpp;

input: (translation_unit | NL+)* EOF; 

translation_unit 
  : preprocessor 
  | ignore 
  ; 

preprocessor 
  : '#' macro_define 
  | '#' macro_include
  ; 

macro_define 
  :   MACRO_DEF macro_name '(' macro_params ')' macro_body 
  |   MACRO_DEF macro_name macro_body 
  |   macro_empty
  ; 

macro_params
  : ID ( ',' ID )*
  ;

macro_empty
  : MACRO_DEF macro_name NL
  ;

macro_include
  : MACRO_INCL INCL_PATH NL
  | MACRO_INCL INCL_PATH NL
  ;

macro_name: ID;

macro_body 
  : ignore
  ; 

ignore 
  : ~NL+  NL+
  | (~NL+ ESCAPED_NL)+ NL+
  ; 

fragment D: [0-9]; 
fragment L: A | '_'; 
fragment A: [a-zA-Z]; 

MACRO_DEF: 'define';
MACRO_INCL: 'include';

INCL_PATH
  : '<' .*? '>'
  | '"' .*? '"'
  ;

LITERAL
  : HEXADECIMAL
  | INTEGER
  | CHAR
  | STRING
  ;


ID          : L (L | D)*;
CHAR        : '\'' ( '\\'? . )+? '\'';
INTEGER     : D+;
HEXADECIMAL : '0' [xX] [0-9a-fA-F]+;
STRING      : '"' ( '\\'? . )*? '"';

BLOCK_COMMENT: '/*' .*? '*/' -> skip;
LINE_COMMENT: '//' .*? '\n' -> skip;
SPECIAL: [+\-*/%&|(){}[\]^!<>=,.;:?];

WS: [ \t]+ -> skip; 
NL: '\r'?'\n';
ESCAPED_NL: '\\' NL;

