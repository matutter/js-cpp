
/**
* This is an ANTLR4 variation of the C99 combined grammar, the original grammar definitions are from multiple sources, this
* is a composit grammar of those specifications.
* https://gist.github.com/codebrainz/2933703
* 
*/

grammar C;

primary_expression
  : IDENTIFIER
  | CONSTANT
  | STRING_LITERAL
  | LPAREN expression RPAREN
  ;

postfix_expression
  : primary_expression
  | postfix_expression LDOMAIN expression RDOMAIN
  | postfix_expression LPAREN RPAREN
  | postfix_expression LPAREN argument_expression_list RPAREN
  | postfix_expression DOT IDENTIFIER
  | postfix_expression PTR_OP IDENTIFIER
  | postfix_expression INC_OP
  | postfix_expression DEC_OP
  | LPAREN type_name RPAREN LSET initializer_list RSET
  | LPAREN type_name RPAREN LSET initializer_list COMMA RSET
  ;

argument_expression_list
  : assignment_expression
  | argument_expression_list COMMA assignment_expression
  ;

unary_expression
  : postfix_expression
  | INC_OP unary_expression
  | DEC_OP unary_expression
  | unary_operator cast_expression
  | SIZEOF unary_expression
  | SIZEOF LPAREN type_name RPAREN
  ;

unary_operator
  : AMPERSAND
  | ASTERISK
  | ADD_OP
  | SUB_OP
  | NEGATE_OP
  | NOT_OP
  ;

cast_expression
  : unary_expression
  | LPAREN type_name RPAREN cast_expression
  ;

multiplicative_expression
  : cast_expression
  | multiplicative_expression ASTERISK cast_expression
  | multiplicative_expression DIV_OP cast_expression
  | multiplicative_expression MOD_OP cast_expression
  ;

additive_expression
  : multiplicative_expression
  | additive_expression ADD_OP multiplicative_expression
  | additive_expression SUB_OP multiplicative_expression
  ;

shift_expression
  : additive_expression
  | shift_expression LEFT_OP additive_expression
  | shift_expression RIGHT_OP additive_expression
  ;

relational_expression
  : shift_expression
  | relational_expression LT_OP shift_expression
  | relational_expression GT_OP shift_expression
  | relational_expression LE_OP shift_expression
  | relational_expression GE_OP shift_expression
  ;

equality_expression
  : relational_expression
  | equality_expression EQ_OP relational_expression
  | equality_expression NE_OP relational_expression
  ;

and_expression
  : equality_expression
  | and_expression AMPERSAND equality_expression
  ;

exclusive_or_expression
  : and_expression
  | exclusive_or_expression XOR_OP and_expression
  ;

inclusive_or_expression
  : exclusive_or_expression
  | inclusive_or_expression OR_OP exclusive_or_expression
  ;

logical_and_expression
  : inclusive_or_expression
  | logical_and_expression AND_OP inclusive_or_expression
  ;

logical_or_expression
  : logical_and_expression
  | logical_or_expression OR_OP logical_and_expression
  ;

conditional_expression
  : logical_or_expression
  | logical_or_expression TERNARY_OP expression COLON conditional_expression
  ;

assignment_expression
  : conditional_expression
  | unary_expression assignment_operator assignment_expression
  ;

assignment_operator
  : EQ
  | MUL_ASSIGN
  | DIV_ASSIGN
  | MOD_ASSIGN
  | ADD_ASSIGN
  | SUB_ASSIGN
  | LEFT_ASSIGN
  | RIGHT_ASSIGN
  | AND_ASSIGN
  | XOR_ASSIGN
  | OR_ASSIGN
  ;

expression
  : assignment_expression
  | expression COMMA assignment_expression
  ;

constant_expression
  : conditional_expression
  ;

declaration
  : declaration_specifiers SEMICOLON
  | declaration_specifiers init_declarator_list SEMICOLON
  ;

declaration_specifiers
  : storage_class_specifier
  | storage_class_specifier declaration_specifiers
  | type_specifier
  | type_specifier declaration_specifiers
  | type_qualifier
  | type_qualifier declaration_specifiers
  | function_specifier
  | function_specifier declaration_specifiers
  ;

init_declarator_list
  : init_declarator
  | init_declarator_list COMMA init_declarator
  ;

init_declarator
  : declarator
  | declarator EQ initializer
  ;

storage_class_specifier
  : TYPEDEF
  | EXTERN
  | STATIC
  | AUTO
  | REGISTER
  ;

type_specifier
  : VOID
  | CHAR
  | SHORT
  | INT
  | LONG
  | FLOAT
  | DOUBLE
  | SIGNED
  | UNSIGNED
  | BOOL
  | COMPLEX
  | IMAGINARY
  | struct_or_union_specifier
  | enum_specifier
  | TYPE_NAME
  ;

struct_or_union_specifier
  : struct_or_union IDENTIFIER LSET struct_declaration_list RSET
  | struct_or_union LSET struct_declaration_list RSET
  | struct_or_union IDENTIFIER
  ;

struct_or_union
  : STRUCT
  | UNION
  ;

struct_declaration_list
  : struct_declaration
  | struct_declaration_list struct_declaration
  ;

struct_declaration
  : specifier_qualifier_list struct_declarator_list SEMICOLON
  ;

specifier_qualifier_list
  : type_specifier specifier_qualifier_list
  | type_specifier
  | type_qualifier specifier_qualifier_list
  | type_qualifier
  ;

struct_declarator_list
  : struct_declarator
  | struct_declarator_list COMMA struct_declarator
  ;

struct_declarator
  : declarator
  | COLON constant_expression
  | declarator COLON constant_expression
  ;

enum_specifier
  : ENUM LSET enumerator_list RSET
  | ENUM IDENTIFIER LSET enumerator_list RSET
  | ENUM LSET enumerator_list COMMA RSET
  | ENUM IDENTIFIER LSET enumerator_list COMMA RSET
  | ENUM IDENTIFIER
  ;

enumerator_list
  : enumerator
  | enumerator_list COMMA enumerator
  ;

enumerator
  : IDENTIFIER
  | IDENTIFIER EQ constant_expression
  ;

type_qualifier
  : CONST
  | RESTRICT
  | VOLATILE
  ;

function_specifier
  : INLINE
  ;

declarator
  : pointer direct_declarator
  | direct_declarator
  ;


direct_declarator
  : IDENTIFIER
  | LPAREN declarator RPAREN
  | direct_declarator LDOMAIN type_qualifier_list assignment_expression RDOMAIN
  | direct_declarator LDOMAIN type_qualifier_list RDOMAIN
  | direct_declarator LDOMAIN assignment_expression RDOMAIN
  | direct_declarator LDOMAIN STATIC type_qualifier_list assignment_expression RDOMAIN
  | direct_declarator LDOMAIN type_qualifier_list STATIC assignment_expression RDOMAIN
  | direct_declarator LDOMAIN type_qualifier_list ASTERISK RDOMAIN
  | direct_declarator LDOMAIN ASTERISK RDOMAIN
  | direct_declarator LDOMAIN RDOMAIN
  | direct_declarator LPAREN parameter_type_list RPAREN
  | direct_declarator LPAREN identifier_list RPAREN
  | direct_declarator LPAREN RPAREN
  ;

pointer
  : ASTERISK
  | ASTERISK type_qualifier_list
  | ASTERISK pointer
  | ASTERISK type_qualifier_list pointer
  ;

type_qualifier_list
  : type_qualifier
  | type_qualifier_list type_qualifier
  ;


parameter_type_list
  : parameter_list
  | parameter_list COMMA ELLIPSIS
  ;

parameter_list
  : parameter_declaration
  | parameter_list COMMA parameter_declaration
  ;

parameter_declaration
  : declaration_specifiers declarator
  | declaration_specifiers abstract_declarator
  | declaration_specifiers
  ;

identifier_list
  : IDENTIFIER
  | identifier_list COMMA IDENTIFIER
  ;

type_name
  : specifier_qualifier_list
  | specifier_qualifier_list abstract_declarator
  ;

abstract_declarator
  : pointer
  | direct_abstract_declarator
  | pointer direct_abstract_declarator
  ;

direct_abstract_declarator
  : LPAREN abstract_declarator RPAREN
  | LDOMAIN RDOMAIN
  | LDOMAIN assignment_expression RDOMAIN
  | direct_abstract_declarator LDOMAIN RDOMAIN
  | direct_abstract_declarator LDOMAIN assignment_expression RDOMAIN
  | LDOMAIN ASTERISK RDOMAIN
  | direct_abstract_declarator LDOMAIN ASTERISK RDOMAIN
  | LPAREN RPAREN
  | LPAREN parameter_type_list RPAREN
  | direct_abstract_declarator LPAREN RPAREN
  | direct_abstract_declarator LPAREN parameter_type_list RPAREN
  ;

initializer
  : assignment_expression
  | LSET initializer_list RSET
  | LSET initializer_list COMMA RSET
  ;

initializer_list
  : initializer
  | designation initializer
  | initializer_list COMMA initializer
  | initializer_list COMMA designation initializer
  ;

designation
  : designator_list EQ
  ;

designator_list
  : designator
  | designator_list designator
  ;

designator
  : LDOMAIN constant_expression RDOMAIN
  | DOT IDENTIFIER
  ;

statement
  : labeled_statement
  | compound_statement
  | expression_statement
  | selection_statement
  | iteration_statement
  | jump_statement
  ;

labeled_statement
  : IDENTIFIER COLON statement
  | CASE constant_expression COLON statement
  | DEFAULT COLON statement
  ;

compound_statement
  : LSET RSET
  | LSET block_item_list RSET
  ;

block_item_list
  : block_item
  | block_item_list block_item
  ;

block_item
  : declaration
  | statement
  ;

expression_statement
  : SEMICOLON
  | expression SEMICOLON
  ;

selection_statement
  : IF LPAREN expression RPAREN statement
  | IF LPAREN expression RPAREN statement ELSE statement
  | SWITCH LPAREN expression RPAREN statement
  ;

iteration_statement
  : WHILE LPAREN expression RPAREN statement
  | DO statement WHILE LPAREN expression RPAREN SEMICOLON
  | FOR LPAREN expression_statement expression_statement RPAREN statement
  | FOR LPAREN expression_statement expression_statement expression RPAREN statement
  | FOR LPAREN declaration expression_statement RPAREN statement
  | FOR LPAREN declaration expression_statement expression RPAREN statement
  ;

jump_statement
  : GOTO IDENTIFIER SEMICOLON
  | CONTINUE SEMICOLON
  | BREAK SEMICOLON
  | RETURN SEMICOLON
  | RETURN expression SEMICOLON
  ;

translation_unit
  : external_declaration
  | translation_unit external_declaration
  ;

external_declaration
  : function_definition
  | declaration
  ;

function_definition
  : declaration_specifiers declarator declaration_list compound_statement
  | declaration_specifiers declarator compound_statement
  ;

declaration_list
  : declaration
  | declaration_list declaration
  ;


fragment D: [0-9];
fragment L: [a-zA-Z_];
fragment H: [a-fA-F0-9];
fragment E: [Ee][+-]? D+;
fragment P: [Pp][+-]? D+;

fragment FS
  : 'f'
  | 'F'
  | 'l'
  | 'L'
  ;

fragment IS
  : ( ('u'|'U')
    | ('u'|'U')? ('l'|'L'|'ll'|'LL')
    | ('l'|'L'|'ll'|'LL') ('u'|'U')
    )
  ;


//"/*"      { comment(); }
//"//"[^\n]*              { /* consume //-comment */ }

AUTO      : 'auto';
BOOL      : '_Bool';
BREAK     : 'break';
CASE      : 'case';
CHAR      : 'char';
COMPLEX   : '_Complex';
CONST     : 'const';
CONTINUE  : 'continue';
DEFAULT   : 'default';
DO        : 'do';
DOUBLE    : 'double';
ELSE      : 'else';
ENUM      : 'enum';
EXTERN    : 'extern';
FLOAT     : 'float';
FOR       : 'for';
GOTO      : 'goto';
IF        : 'if';
IMAGINARY : '_Imaginary';
INLINE    : 'inline';
INT       : 'int';
LONG      : 'long';
REGISTER  : 'register';
RESTRICT  : 'restrict';
RETURN    : 'return';
SHORT     : 'short';
SIGNED    : 'signed';
SIZEOF    : 'sizeof';
STATIC    : 'static';
STRUCT    : 'struct';
SWITCH    : 'switch';
TYPEDEF   : 'typedef';
UNION     : 'union';
UNSIGNED  : 'unsigned';
VOID      : 'void';
VOLATILE  : 'volatile';
WHILE     : 'while';

IDENTIFIER: L ( L | D )*;

CONSTANT
  : ('0' [xX] H+ IS?)
  | ('0' [0-7]* IS?)
  | ([1-9] D* IS?)
    // what the heck does this match? single character literals?
  | (L? '\'' ( '\\'. | ~[\\'\n] )+ '\'')
  | (D+ E FS?)
  | (D* '.' D+ E? FS?)
  | ('0' [xX] H+ P FS?)
  | ('0' [xX] H* '.' H+ P? FS?)
  ;

STRING_LITERAL: L? '"' (~[\\"] | '\\' [\\"])* '"';

ELLIPSIS     : '...';
RIGHT_ASSIGN : '>>=';
LEFT_ASSIGN  : '<<=';
ADD_ASSIGN   : '+=';
SUB_ASSIGN   : '-=';
MUL_ASSIGN   : '*=';
DIV_ASSIGN   : '/=';
MOD_ASSIGN   : '%=';
AND_ASSIGN   : '&=';
XOR_ASSIGN   : '^=';
OR_ASSIGN    : '|=';
RIGHT_OP     : '>>';
LEFT_OP      : '<<';
INC_OP       : '++';
DEC_OP       : '--';
PTR_OP       : '->';
AND_OP       : '&&';
OR_OP        : '||';
LE_OP        : '<=';
GE_OP        : '>=';
EQ_OP        : '==';
NE_OP        : '!=';

SEMICOLON   : ';';
COLON       : ':';
COMMA       : ',';
LDOMAIN     : '[' | '<:';
RDOMAIN     : ']' | ':>';
LSET        : '{' | '<%';
RSET        : '}' | '%>';
LPAREN      : '(';
RPAREN      : ')';
DOT         : '.';
EQ          : '=';
AMPERSAND   : '&';
ASTERISK    : '*';

NOT_OP     : '!';
TERNARY_OP : '?';
SUB_OP     : '-';
ADD_OP     : '+';
DIV_OP     : '/';
MOD_OP     : '%';
LT_OP      : '<';
GT_OP      : '>';
XOR_OP     : '^';
OR_OP      : '|';
NEGATE_OP  : '~';

WS: [ \t\v\n\f] -> skip;

//UNKNOWN: .     { /* Add code to complain about unmatched characters */ }
