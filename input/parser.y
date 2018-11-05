%{
#include <iostream>
#include <cstring>

    extern int yylex();
    extern int yyparse();

    extern void yyerror(const char *str);

    extern int yylineno;
    extern const char* yytext;
%}

%union
{
    double dval;
    const char *string;
}

%token KWD_FUNCTION
%token KWD_IF
%token KWD_ELSE
%token KWD_RESULT
%token KWD_NUMBER
%token KWD_NOTHING
%token KWD_TEXT
%token KWD_CONSTANT
%token KWD_WHILE
%token KWD_AND
%token KWD_OR

%token OP_COLON
%token OP_COMMA
%token OP_ARROW
%token OP_DOT
%token OP_SEMICOLON
%token OP_OPEN_ROUND_BRACKET
%token OP_CLOSE_ROUND_BRACKET
%token OP_OPEN_SQUARE_BRACKET
%token OP_CLOSE_SQUARE_BRACKET
%token OP_OPEN_CURLY_BRACKET
%token OP_CLOSE_CURLY_BRACKET

%token BLOCK_OPEN
%token BLOCK_CLOSE
%token LINEBREAK

%token <dval>   NUMBER
%token <string> IDENTIFIER

%left OP_EQUAL OP_UNEQUAL

%left OP_OPEN_ANGULAR_BRACKET OP_CLOSE_ANGULAR_BRACKET 
      OP_SMALLER_EQ OP_GREATER_EQ

%left OP_PLUS OP_MINUS

%left OP_STAR OP_SLASH OP_PERCENT

%right OP_ASSIGN
/*
%left OP_EQUAL OP_UNEQUAL

%left OP_OPEN_ANGULAR_BRACKET OP_CLOSE_ANGULAR_BRACKET 
      OP_SMALLER_EQ OP_GREATER_EQ

%left OP_PLUS OP_MINUS

%left OP_STAR OP_SLASH OP_PERCENT

%right OP_ASSIGN
*/
%%

translation_unit:
      line
    | translation_unit line
    ;

line:
     LINEBREAK /*empty line*/
    | statement LINEBREAK
    | function_declaration LINEBREAK
    ;

function_declaration:
      KWD_FUNCTION IDENTIFIER OP_COLON function_parameters
    ;

function_parameters:
      parameter_list OP_ARROW type_list
    ;

statement:
      BLOCK_OPEN statement
    | expression
    | data_field_definition
    | while_statement
    | result_statement
    | if_statement
    | else_if_statement
    | else_statement
    ;

while_statement:
      KWD_WHILE expression OP_COLON
    ;

result_statement:
      KWD_RESULT OP_COLON nonempty_argument_list
    | KWD_RESULT OP_COLON KWD_NOTHING
    ;

if_statement:
      KWD_IF expression OP_COLON
    ;

else_if_statement:
      KWD_ELSE KWD_IF expression OP_COLON
    ;

else_statement:
      KWD_ELSE OP_COLON
    ;

data_field_declaration:
      type OP_COLON IDENTIFIER
    ;

data_field_definition:
      type OP_COLON data_field_assigment_list
    ;

data_field_assigment_list:
      assignment_expression
    | data_field_assigment_list OP_COMMA assignment_expression
    ;

expression:
      assignment_expression
    | arith_compare_expression
    | function_call
    | value
    | IDENTIFIER
    | OP_OPEN_ROUND_BRACKET expression OP_CLOSE_ROUND_BRACKET
    ;

assignment_expression:
      IDENTIFIER OP_ASSIGN expression
    ;

arith_compare_expression:
      expression arithmetic_operator expression
    | expression comparison_operator expression
    ;

arithmetic_operator:
      OP_PLUS
    | OP_MINUS
    | OP_STAR
    | OP_SLASH
    | OP_PERCENT
    ;

comparison_operator:
      OP_OPEN_ANGULAR_BRACKET
    | OP_CLOSE_ANGULAR_BRACKET
    | OP_SMALLER_EQ
    | OP_GREATER_EQ
    | OP_EQUAL
    | OP_UNEQUAL
    ;

function_call:
      IDENTIFIER OP_OPEN_ROUND_BRACKET argument_list OP_CLOSE_ROUND_BRACKET
    ;

argument_list:
      /*empty*/
    | nonempty_argument_list
    ;

nonempty_argument_list:
      expression
    | argument_list OP_COMMA expression
    ;

parameter_list:
      data_field_declaration
    | parameter_list OP_COMMA data_field_declaration
    ;

type_list:
      type
    | type_list OP_COMMA type
    ;

value:
      NUMBER
    ;

type:
      _type
    | KWD_CONSTANT _type
    ;

_type:
      KWD_NUMBER
    | KWD_NOTHING
    | KWD_TEXT
    ;

%%
void yyerror(const char *str)
{
    std::cout << "Error: " << yylineno << " \"" << yytext << "\" " << str << "\n";
    exit(-1);
}
