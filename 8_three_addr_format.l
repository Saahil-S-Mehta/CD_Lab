%{
    #include "y.tab.h"
    // extern char yylval;
%}

%%
[0-9]+ {yylval.sym = (char)yytext[0]; return num;}
[a-zA-Z]+ {yylval.sym = (char)yytext[0]; return id;}
"=" {yylval.sym = (char)yytext[0]; return assign;}
"+" {yylval.sym = (char)yytext[0]; return plus;}
"-" {yylval.sym = (char)yytext[0]; return minus;}
"*" {yylval.sym = (char)yytext[0]; return mult;}
"/" {yylval.sym = (char)yytext[0]; return divi;}
\n return 0;
. {return yytext[0];}
%%