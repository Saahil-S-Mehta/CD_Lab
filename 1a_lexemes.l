%{
#include<stdio.h>
#include<string.h>
int words=0, whitespace=0, ch=0, line=1;
%}
%%
[ ] {whitespace++;}
[\t] {whitespace+=4;}
[\n] {line++;}
[^ \t\n#]+ {words++;
ch+=strlen(yytext);} // ch+=yylen();
.;
# return 0;
%%
int yywrap(){}
int main(){
printf("Enter input (enter # to exit)\n");
yylex();
printf("Whitespace: %d\nLines: %d\nCharacters: %d\nWords: %d\n", whitespace, line, ch, words);
return 0;
}
