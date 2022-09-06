%{
#include<stdio.h>
int comment=0,flag=0,c=1;
%}
%%
"//"[^\n]* {if(flag==0)comment++;}
"/*" {flag=1;}
"*/"  {if(flag==1)
         {flag=0;
         comment+=c;
         c=1;}
      else
         fprintf(yyout,"*/");
      }
[\n] {if(flag==1) 
         c++;
      else
         fprintf(yyout,"%c",yytext[0]);    
      }
.     {if (flag==0) {
         fprintf(yyout,"%c",yytext[0]);
      }
      }
EOF return 0;
%%
int yywrap() {
   return 1;
}
void main(){
   yyin=fopen("test.c","r");
   yyout=fopen("output.txt","w");
   yylex();
   printf("The number of comment lines are %d\n",comment);
}