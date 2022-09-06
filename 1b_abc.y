%{
#include <stdio.h>
#include <stdlib.h>
%}
%token X
%token Y
%token Z
%%
S:A B
;
A:X A Y
|
;
B:Y B Z
|
;
%%
int main(){
	printf("Enter the input: ");
	yyparse();
	printf("Valid\n");
	return 0;
}
void yyerror(void){
	printf("Invalid\n");
	exit(0);
}