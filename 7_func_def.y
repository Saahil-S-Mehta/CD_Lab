%{
#include <stdio.h>
#include <stdlib.h>
%}

%token TYPE ID RETURN NUM

%%
S : FUN {printf("Input accepted\n"); exit(0);}
;
FUN : TYPE '(' PARAM ')' '{' BODY '}'   // with parameters
| TYPE '(' ')' '{' BODY '}'             // no parameters
;
PARAM : TYPE ',' PARAM
| TYPE
;
BODY : VAR ';' BODY   // var declaration
| E ';' BODY            // statements   
| RETURN E ';'          // return stat
|                       // empty body
;    
VAR : TYPE ',' CHAINID  // int a,b,c
| TYPE
;     
CHAINID : ID ',' CHAINID
| ID
;           
E : ID '=' E
| E '+' E
| E '-' E
| E '*' E
| E '/' E       
| ID
| NUM   
;
%%

int yyerror(char *msg)
{
printf("the statement is invalid\n");
exit(0);
}

int main()
{
    printf("Enter the expression:\n");
    yyparse();
    return 0;
}
