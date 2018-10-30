%{
    #include <iostream>
%}

%option yylineno

%%
Funktion {std::cout << "Funktion\n";}
wenn {std::cout << "wenn\n";}
sonst {std::cout << "sonst\n";}
Ergebnis {std::cout << "Ergebnis\n";}
Zahl {std::cout << "Zahl\n";}
Nichts {std::cout << "Nichts\n";}
Text {std::cout << "Text\n";}
Konstanter {std::cout << "Konstanter\n";}
Konstante {std::cout << "Konstante\n";}
Konstantes {std::cout << "Konstantes\n";}
Solange {std::cout << "Solange\n";}
und {std::cout << "und\n";}
oder {std::cout << "oder\n";}

:  {std::cout << "Colon\n";}
,  {std::cout << "Comma\n";}
-> {std::cout << "Arrow\n";}
:= {std::cout << "Assign\n";}
\.  {std::cout << "Dot\n";}
;  {std::cout << "Semicolon\n";}
\( {std::cout << "Round_Bracket_Open\n";}
\) {std::cout << "Round_Bracket_Close\n";}
\[ {std::cout << "Square_Bracket_Open\n";}
\] {std::cout << "Square_Bracket_Close\n";}
\{ {std::cout << "Curly_Bracket_Open\n";}
\} {std::cout << "Curly_Bracket_Close\n";}
\+ {std::cout << "Plus\n";}
-  {std::cout << "Minus\n";}
\* {std::cout << "Star\n";}
\/  {std::cout << "Slash\n";}
%   {std::cout << "Percent\n";}
\<  {std::cout << "Angular_Bracket_Open\n";}
\>  {std::cout << "Angular_Bracket_Close\n";}
\<= {std::cout << "Smaller_EQ\n";}
\>= {std::cout << "Greater_EQ\n";}
!=  {std::cout << "Unequal\n";}
=   {std::cout <<  "Equal\n";}


\"
\'

\+?[0-9]+(\.[0-9]+)?       {std::cout << "Pos_Zahl\n";}
-[0-9]+(\.[0-9]+)?       {std::cout << "Neg_Zahl\n";}
[_A-Za-z][_A-Za-z0-9]* {std::cout << "Name\n";}
[ \n\t]+ {}
. {std::cout << "Error: " << yylineno << "\n";}
%%
int main()
{
    yylex();
    return 0;
}

extern "C" int yywrap(void)
{

}