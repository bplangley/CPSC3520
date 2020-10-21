%{
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
int yylex (void);
int yyerror(char *s);
int aCount=0;
int bCount=0;
int cCount=0;
int dCount=0;
int eCount=0;

%}

%token A
%token B
%token C
%token D
%token E



%%

string: error {yyerror("\nSorry, Charlie, input string not in L(G)\n");exit(1);}
    | as bs cs ds es  {if(aCount!=eCount || cCount!=dCount || (aCount || cCount ||bCount)<=0 ){
                            yyerror("");}
                        else{printf("\n\n*****Congratulations; parse successful*****\n\n");}}
    | es ds cs bs as {if(eCount!=2*aCount || cCount!=3*bCount || dCount!=2)
                        {yyerror("");}
                    else{printf("\n\n*****Congratulations; parse successful*****\n\n" );}}



;
as: A as | A
;
bs: B bs | B
;
cs: C cs | C
;
ds: D ds | D
;
es: E es | E
;

%%
