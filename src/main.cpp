
#include <iostream>

extern int yylex();
extern int yyparse();

int main()
{
    if(yyparse() == 0)
        std::cout << "ACCEPTED\n";

    return 0;
}
