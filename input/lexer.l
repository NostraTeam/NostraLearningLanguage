%{
    #include <iostream>
    #include "parser.hpp"

    int indentCounter = 0;
    bool foundNonWhitespace = false;
    int loc = 0;
%}

%option yylineno

UNSIGNED_NUMBER [0-9]+(\.[0-9]+)?

%%
Funktion    {
                foundNonWhitespace = true;
                return FUNCTION;
            }

wenn        {
                foundNonWhitespace = true;
                return IF;
            }

sonst       {
                foundNonWhitespace = true;
                return ELSE;
            }

Ergebnis    {
                foundNonWhitespace = true;
                return RESULT;
            }

Zahl        {
                foundNonWhitespace = true;
                return NUMBER;
            }

Nichts      {
                foundNonWhitespace = true;
                return NOTHING;
            }

Text        {
                foundNonWhitespace = true;
                return TEXT;
            }

Konstanter  {
                foundNonWhitespace = true;
                return CONSTANT;
            }

Konstante   {
                foundNonWhitespace = true;
                return CONSTANT;
            }

Konstantes  {
                foundNonWhitespace = true;
                return CONSTANT;
            }

Solange     {
                foundNonWhitespace = true;
                return WHILE;
            }

und         {
                foundNonWhitespace = true;
                return AND;
            }

oder        {
                foundNonWhitespace = true;
                return OR;
            }

:   {
        foundNonWhitespace = true;
        return OP_COLON;
    }

,   {
        foundNonWhitespace = true;
        return OP_COMMA;
    }

->  {
        foundNonWhitespace = true;
        return OP_ARROW;
    }

:=  {
        foundNonWhitespace = true;
        return OP_ASSIGN;
    }

\.  {
        foundNonWhitespace = true;
        return OP_DOT;
    }

;   {
        foundNonWhitespace = true;
        return OP_SEMICOLON;
    }

\(  {
        foundNonWhitespace = true;
        return OP_OPEN_ROUND_BRACKET;
    }

\)  {
        foundNonWhitespace = true;
        return OP_CLOSE_ROUND_BRACKET;
    }

\[  {
        foundNonWhitespace = true;
        return OP_OPEN_SQUARE_BRACKET;
    }

\]  {
        foundNonWhitespace = true;
        return OP_CLOSE_SQUARE_BRACKET;
    }

\{  {
        foundNonWhitespace = true;
        return OP_OPEN_CURLY_BRACKET;
    }

\}  {
        foundNonWhitespace = true;
        return OP_CLOSE_CURLY_BRACKET;
    }

\+  {
        foundNonWhitespace = true;
        return OP_PLUS;
    }

-   {
        foundNonWhitespace = true;
        return OP_MINUS;
    }

\*  {
        foundNonWhitespace = true;
        return OP_STAR;
    }

\/  {
        foundNonWhitespace = true;
        return OP_SLASH;
    }

%   {
        foundNonWhitespace = true;
        return OP_PERCENT;
    }

\<  {
        foundNonWhitespace = true;
        return OP_OPEN_ANGULAR_BRACKET;
    }

\>  {
        foundNonWhitespace = true;
        return OP_CLOSE_ANGULAR_BRACKET;
    }

\<= {
        foundNonWhitespace = true;
        return OP_SMALLER_EQ;
    }

\>= {
        foundNonWhitespace = true;
        return OP_GREATER_EQ;
    }

!=  {
        foundNonWhitespace = true;
        return OP_UNEQUAL;
    }

=   {
        foundNonWhitespace = true;
        return OP_EQUAL;
    }


#.*                     {
                            
                        }

\+?{UNSIGNED_NUMBER}    {
                            foundNonWhitespace = true;
                            return NUMBER_VALUE;
                        }

-{UNSIGNED_NUMBER}      {
                            foundNonWhitespace = true;
                            return NUMBER_VALUE;
                        }

[_A-Za-z][_A-Za-z0-9]*  {
                            foundNonWhitespace = true;
                            return NAME;
                        }

^([ ]{4}|\t)            {
                            indentCounter++; 
                        }

([ ]{4}|\t)             {
                            if(indentCounter > 0 && !foundNonWhitespace)
                            {
                                indentCounter++;
                            }
                        }

\n                      {
                            indentCounter = 0;
                            foundNonWhitespace = false;
                            loc++;
                            return LINEBREAK;
                        }

[ \t]                   {

                        }

.                       {
                            std::cout << "Flex: Invalid match: " << yytext << "\n";
                            exit(-2);
                        }
%%

extern "C" int yywrap(void)
{

}