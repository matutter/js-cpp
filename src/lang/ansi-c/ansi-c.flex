%{
  #include <cerrno>
  #include <climits>
  #include <cstdlib>
  #include <string>
  
  #include "debug.h"
  #include "ansi-c.driver.hh"
  #include "lang/grammar/ansi-c.tab.hh"

  #undef yywrap
  #define yywrap() 1

  // The location of the current token.
  static yy::location loc;
%}

%option outfile="ansi-c.yy.cc" header-file="ansi-c.yy.hh"
%option noyywrap nounput batch debug noinput


D   [0-9]
L   [a-zA-Z_]
H   [a-fA-F0-9]
E   [Ee][+-]?{D}+
FS  (f|F|l|L)
IS  (u|U|l|L)*

%{
  // Code run each time a pattern is matched.
  #define YY_USER_ACTION  loc.columns (yyleng);
%}
%%
%{
  // Code run each time yylex is called.
  loc.step ();
%}

"/*"       { driver.comment(); }
"auto"     return yy::AnsiCParser::make_AUTO(loc);
"break"    return yy::AnsiCParser::make_BREAK(loc);
"case"     return yy::AnsiCParser::make_CASE(loc);
"char"     return yy::AnsiCParser::make_CHAR(loc);
"const"    return yy::AnsiCParser::make_CONST(loc);
"continue" return yy::AnsiCParser::make_CONTINUE(loc);
"default"  return yy::AnsiCParser::make_DEFAULT(loc);
"do"       return yy::AnsiCParser::make_DO(loc);
"double"   return yy::AnsiCParser::make_DOUBLE(loc);
"else"     return yy::AnsiCParser::make_ELSE(loc);
"enum"     return yy::AnsiCParser::make_ENUM(loc);
"extern"   return yy::AnsiCParser::make_EXTERN(loc);
"float"    return yy::AnsiCParser::make_FLOAT(loc);
"for"      return yy::AnsiCParser::make_FOR(loc);
"goto"     return yy::AnsiCParser::make_GOTO(loc);
"if"       return yy::AnsiCParser::make_IF(loc);
"int"      return yy::AnsiCParser::make_INT(loc);
"long"     return yy::AnsiCParser::make_LONG(loc);
"register" return yy::AnsiCParser::make_REGISTER(loc);
"return"   return yy::AnsiCParser::make_RETURN(loc);
"short"    return yy::AnsiCParser::make_SHORT(loc);
"signed"   return yy::AnsiCParser::make_SIGNED(loc);
"sizeof"   return yy::AnsiCParser::make_SIZEOF(loc);
"static"   return yy::AnsiCParser::make_STATIC(loc);
"struct"   return yy::AnsiCParser::make_STRUCT(loc);
"switch"   return yy::AnsiCParser::make_SWITCH(loc);
"typedef"  return yy::AnsiCParser::make_TYPEDEF(loc);
"union"    return yy::AnsiCParser::make_UNION(loc);
"unsigned" return yy::AnsiCParser::make_UNSIGNED(loc);
"void"     return yy::AnsiCParser::make_VOID(loc);
"volatile" return yy::AnsiCParser::make_VOLATILE(loc);
"while"    return yy::AnsiCParser::make_WHILE(loc);

{L}({L}|{D})*    return yy::AnsiCParser::make_IDENTIFIER(loc);

0[xX]{H}+{IS}?    return yy::AnsiCParser::make_CONSTANT(loc);
0{D}+{IS}?        return yy::AnsiCParser::make_CONSTANT(loc);
{D}+{IS}?         return yy::AnsiCParser::make_CONSTANT(loc);
{D}+{E}{FS}?            return yy::AnsiCParser::make_CONSTANT(loc);
{D}*"."{D}+({E})?{FS}?  return yy::AnsiCParser::make_CONSTANT(loc);
{D}+"."{D}*({E})?{FS}?  return yy::AnsiCParser::make_CONSTANT(loc);

L?'(\\.|[^\\'])+' return yy::AnsiCParser::make_CONSTANT(loc);
L?\"(\\.|[^\\"])*\" return yy::AnsiCParser::make_STRING_LITERAL(loc);

"..."     return yy::AnsiCParser::make_ELLIPSIS(loc);
">>="     return yy::AnsiCParser::make_RIGHT_ASSIGN(loc);
"<<="     return yy::AnsiCParser::make_LEFT_ASSIGN(loc);
"+="      return yy::AnsiCParser::make_ADD_ASSIGN(loc);
"-="      return yy::AnsiCParser::make_SUB_ASSIGN(loc);
"*="      return yy::AnsiCParser::make_MUL_ASSIGN(loc);
"/="      return yy::AnsiCParser::make_DIV_ASSIGN(loc);
"%="      return yy::AnsiCParser::make_MOD_ASSIGN(loc);
"&="      return yy::AnsiCParser::make_AND_ASSIGN(loc);
"^="      return yy::AnsiCParser::make_XOR_ASSIGN(loc);
"|="      return yy::AnsiCParser::make_OR_ASSIGN(loc);
">>"      return yy::AnsiCParser::make_RIGHT_OP(loc);
"<<"      return yy::AnsiCParser::make_LEFT_OP(loc);
"++"      return yy::AnsiCParser::make_INC_OP(loc);
"--"      return yy::AnsiCParser::make_DEC_OP(loc);
"->"      return yy::AnsiCParser::make_PTR_OP(loc);
"&&"      return yy::AnsiCParser::make_AND_OP(loc);
"||"      return yy::AnsiCParser::make_OR_OP(loc);
"<="      return yy::AnsiCParser::make_LE_OP(loc);
">="      return yy::AnsiCParser::make_GE_OP(loc);
"=="      return yy::AnsiCParser::make_EQ_OP(loc);
"!="      return yy::AnsiCParser::make_NE_OP(loc);
";"       return yy::AnsiCParser::make_SEMICOLON(loc);
("{"|"<%")    return yy::AnsiCParser::make_LSET(loc);
("}"|"%>")    return yy::AnsiCParser::make_RSET(loc);
","       return yy::AnsiCParser::make_COMMA(loc);
":"       return yy::AnsiCParser::make_COLON(loc);
"="       return yy::AnsiCParser::make_EQ(loc);
"("       return yy::AnsiCParser::make_LPAREN(loc);
")"       return yy::AnsiCParser::make_RPAREN(loc);
("["|"<:")    return yy::AnsiCParser::make_LDOMAIN(loc);
("]"|":>")    return yy::AnsiCParser::make_RDOMAIN(loc);
"."       return yy::AnsiCParser::make_FS(loc);
"&"       return yy::AnsiCParser::make_BIN_AND(loc);
"!"       return yy::AnsiCParser::make_LOGIC_NOT(loc);
"~"       return yy::AnsiCParser::make_BIN_ONES_COMP(loc);
"-"       return yy::AnsiCParser::make_SUBTRACTION(loc);
"+"       return yy::AnsiCParser::make_ADDITION(loc);
"*"       return yy::AnsiCParser::make_MULTIPLICATION(loc);
"/"       return yy::AnsiCParser::make_DIVISION(loc);
"%"       return yy::AnsiCParser::make_MODULUS(loc);
"<"       return yy::AnsiCParser::make_LANGLE(loc);
">"       return yy::AnsiCParser::make_RANGLE(loc);
"^"       return yy::AnsiCParser::make_BIN_XOR(loc);
"|"       return yy::AnsiCParser::make_BIN_OR(loc);
"?"       return yy::AnsiCParser::make_CONDITION(loc);

[ \t\v\n\f]   {  }

<<EOF>>  return yy::AnsiCParser::make_END(loc);

%%

void AnsiCDriver::scan_begin() {
  yy_flex_debug = trace_scanning;
  if (file.empty() || file == "-") {
    yyin = stdin;
  } else if(!(yyin = fopen(file.c_str (), "r"))) {
    error("cannot open " + file + ": " + strerror(errno));
    exit(EXIT_FAILURE);
  }
}

void AnsiCDriver::scan_end() {
  fclose(yyin);
}
