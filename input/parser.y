%{
#include <iostream>
#include <cstring>

    extern int yylex();
    extern int yyparse();

    extern void yyerror(const char *str);

    extern int loc;
    extern const char* yytext;
%}

%start translation_unit

%union
{
    double dval;
    const char *string;
}

%token FUNCTION
%token IF
%token ELSE
%token RESULT
%token NUMBER
%token NOTHING
%token TEXT
%token CONSTANT
%token WHILE
%token AND
%token OR

%token OP_COLON
%token OP_COMMA
%token OP_ARROW
%token OP_ASSIGN
%token OP_DOT
%token OP_SEMICOLON
%token OP_OPEN_ROUND_BRACKET
%token OP_CLOSE_ROUND_BRACKET
%token OP_OPEN_SQUARE_BRACKET
%token OP_CLOSE_SQUARE_BRACKET
%token OP_OPEN_CURLY_BRACKET
%token OP_CLOSE_CURLY_BRACKET
%token OP_PLUS
%token OP_MINUS
%token OP_STAR
%token OP_SLASH
%token OP_PERCENT
%token OP_OPEN_ANGULAR_BRACKET
%token OP_CLOSE_ANGULAR_BRACKET
%token OP_SMALLER_EQ
%token OP_GREATER_EQ
%token OP_UNEQUAL
%token OP_EQUAL

%token LINEBREAK

%token <dval>   NUMBER_VALUE;
%token <string> NAME;

%%
translation_unit:
    any_expression {std::cout << "translation_unit" << "\n";}
    | translation_unit any_expression {std::cout << "translation_unit" << "\n";}
    ;

any_expression:
    function_defintion {std::cout << "any_expression" << "\n";}
    | statements {std::cout << "any_expression" << "\n";}
    ;

function_defintion:
    function_header function_body {std::cout << "function_defintion" << "\n";}
    ;

function_header:
    FUNCTION NAME OP_COLON linebreak
    function_parameter_definition OP_ARROW function_return_type_definition linebreak
    {std::cout << "function_header" << "\n";}
    ;

function_parameter_definition:
    variable_declaration  {std::cout << "function_parameter_definition" << "\n";}
    | function_parameter_definition OP_COMMA variable_declaration {std::cout << "function_parameter_definition" << "\n";}
    ;

function_return_type_definition:
    type {std::cout << "function_return_type_definition" << "\n";}
    | type OP_COMMA function_return_type_definition {std::cout << "function_return_type_definition" << "\n";}
    ;

function_body:
    statements {std::cout << "function_body" << "\n";}
    ;

statements:
    statement {std::cout << "statements" << "\n";}
    | statements statement {std::cout << "statements" << "\n";}
    ;

statement:
    _statement linebreak {std::cout << "statement\n";}
    ;

_statement:
    expression {std::cout << "_statement" << "\n";}
    | while_statement {std::cout << "_statement" << "\n";}
    | void_statement {std::cout << "_statement" << "\n";}
    ;

while_statement:
    while_statement_head linebreak statements {std::cout << "while_statement\n";}
    ;

while_statement_head:
    WHILE expression OP_COLON {std::cout << "while_statement_head\n";}
    ;

void_statement:
    {std::cout << "void_statement\n";}
    ;

expression:
    variable_definition {std::cout << "expression" << "\n";}
    | assignment {std::cout << "expression" << "\n";}
    | call {std::cout << "expression" << "\n";}
    | arithmetic_expression {std::cout << "expression" << "\n";}
    | value {std::cout << "expression" << "\n";}
    | NAME {std::cout << "expression" << "\n";}
    ;

assignment:
    NAME OP_ASSIGN expression {std::cout << "assignment" << "\n";}
    ;

call:
    NAME OP_OPEN_ROUND_BRACKET call_parameter_list OP_CLOSE_ROUND_BRACKET {std::cout << "call" << "\n";}
    ;

call_parameter_list:
    expression {std::cout << "call_parameter_list" << "\n";}
    | call_parameter_list OP_COMMA expression {std::cout << "call_parameter_list" << "\n";}
    | {std::cout << "call_parameter_list" << "\n";}
    ;

arithmetic_expression:
    expression arithmetic_operator expression {std::cout << "arithmetic_expression" << "\n";}
    ;

arithmetic_operator:
    OP_PLUS {std::cout << "arithmetic_operator" << "\n";}
    | OP_MINUS {std::cout << "arithmetic_operator" << "\n";}
    | OP_STAR {std::cout << "arithmetic_operator" << "\n";}
    | OP_SLASH {std::cout << "arithmetic_operator" << "\n";}
    | arithmetic_operator_compare {std::cout << "arithmetic_operator" << "\n";}
    ;

arithmetic_operator_compare:
    OP_EQUAL {std::cout << "arithmetic_operator_compare" << "\n";}
    | OP_UNEQUAL {std::cout << "arithmetic_operator_compare" << "\n";}
    | OP_OPEN_ANGULAR_BRACKET {std::cout << "arithmetic_operator_compare" << "\n";}
    | OP_CLOSE_ANGULAR_BRACKET {std::cout << "arithmetic_operator_compare" << "\n";}
    | OP_SMALLER_EQ {std::cout << "arithmetic_operator_compare" << "\n";}
    | OP_GREATER_EQ {std::cout << "arithmetic_operator_compare" << "\n";}
    ;

variable_declaration:
    type OP_COLON NAME {std::cout << "variable declaration" << "\n";}
    ;

variable_definition:
    variable_declaration OP_EQUAL NUMBER_VALUE {std::cout << "variable_definition" << "\n";}
    ;

type:
    TEXT {std::cout << "type" << "\n";}
    | NUMBER {std::cout << "type" << "\n";}
    | NOTHING {std::cout << "type" << "\n";}
    ;

value:
    NUMBER_VALUE {std::cout << "value" << "\n";}
    ;

linebreak:
    LINEBREAK {std::cout << "linebreak" << "\n";}
    | linebreak LINEBREAK {std::cout << "linebreak" << "\n";}
    ;
%%
void yyerror(const char *str)
{
    std::cout << "Error: " << loc << " \"" << yytext << "\" " << str << "\n";
    exit(-1);
}
