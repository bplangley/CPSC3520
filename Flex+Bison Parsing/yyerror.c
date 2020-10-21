int yyerror(s)
char*s;
{
printf("%s\n",s);
printf("\nSorry, Charlie, input string not in L(G)\n\n");
exit(1);
return -1;
}
