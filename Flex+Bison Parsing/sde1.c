#include "sde1.tab.c"
#include "lex.yy.c"
#include "yyerror.c"
//#define YYERROR_VERBOSE

int main(){
    printf("\n>>>>CONTEXTUAL parsing of string<<<<<<");
    yyparse();
    return 1;
}
