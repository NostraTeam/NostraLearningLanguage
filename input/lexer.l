%{
    #include <iostream>
    #include "parser.hpp"

    int indentCounter = 0;
    int lastIndent = 0;
    bool foundNonWhitespace = false;
%}

%option yylineno
%option noyywrap

UNSIGNED_NUMBER [0-9]+(\.[0-9]+)?

%%
Funktion    {
                foundNonWhitespace = true;
                return KWD_FUNCTION;
            }

wenn        {
                foundNonWhitespace = true;
                return KWD_IF;
            }

sonst       {
                foundNonWhitespace = true;
                return KWD_ELSE;
            }

Ergebnis    {
                foundNonWhitespace = true;
                return KWD_RESULT;
            }

Zahl        {
                foundNonWhitespace = true;
                return KWD_NUMBER;
            }

Nichts      {
                foundNonWhitespace = true;
                return KWD_NOTHING;
            }

Text        {
                foundNonWhitespace = true;
                return KWD_TEXT;
            }

Konstanter  {
                foundNonWhitespace = true;
                return KWD_CONSTANT;
            }

Konstante   {
                foundNonWhitespace = true;
                return KWD_CONSTANT;
            }

Konstantes  {
                foundNonWhitespace = true;
                return KWD_CONSTANT;
            }

Solange     {
                foundNonWhitespace = true;
                return KWD_WHILE;
            }

und         {
                foundNonWhitespace = true;
                return KWD_AND;
            }

oder        {
                foundNonWhitespace = true;
                return KWD_OR;
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

[-+]?{UNSIGNED_NUMBER}  {
                            foundNonWhitespace = true;
                            return NUMBER;
                        }

[_A-Za-z][_A-Za-z0-9]*  {
                            foundNonWhitespace = true;
                            return IDENTIFIER;
                        }

^([ ]{4}|\t)            {
                            indentCounter++;

                            if(indentCounter > lastIndent)
                            {
                                std::cout << "BLOCK_OPEN" << "\n";
                            
                                return BLOCK_OPEN;
                            }
                        }

([ ]{4}|\t)             {
                            if(indentCounter > 0 && !foundNonWhitespace)
                                indentCounter++;

                            if(indentCounter > lastIndent)
                            {
                                std::cout << "BLOCK_OPEN" << "\n";
                            
                                return BLOCK_OPEN;
                            }
                        }

\n                      {
                            lastIndent = indentCounter;
                            indentCounter = 0;
                            foundNonWhitespace = false;
                            return LINEBREAK;
                        }

[ \t]                   {

                        }

.                       {
                            std::cout << "Flex: Invalid match: " << yytext << "\n";
                            exit(-2);
                        }
%%
