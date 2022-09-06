%{
#include<stdio.h>
#include<string.h>
int keywords=0, ids=0, op=0;
%}
%%
("int"|"float"|"auto"|"const"|"double"|"short"|"struct"|"unsigned"|"break"|"continue"|"else"|"if"|"for"|"long"|"signed"|"switch"|"void"|"case"|"default"|"enum"|"goto"|"register"|"sizeof"|"char"|"return"|"while"|"do") {printf("Keyword\n");
keywords++;}
[a-zA-Z_][a-zA-Z_0-9]* {printf("Identifier\n");ids++;}
("+"|"-"|"*"|"/"|"<"|">"|"="|"=="|"<="|">="|"!=") {printf("Operator\n");op++;}
.;
# return 0;
%%
int yywrap(){}
int main(){
printf("Enter input (enter # to exit)\n");
yylex();
printf("Keywords: %d\nIdentifiers: %d\nOperators: %d\n", keywords, ids, op);
return 0;
}
