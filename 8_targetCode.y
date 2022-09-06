%{
#include<stdio.h>
#include<stdlib.h>
void ThreeAddressCode();
void triple();
void qudraple();
char AddToTable(char ,char, char);
int ind=0;
char temp='A';
struct incod
{
    char opd1;
    char opd2;
    char opr;
};
%}

%union
{
    char sym;
}
%token <sym> LETTER NUMBER
%type <sym> expr
%left '-' '+'
%left '*' '/'

%%
statement: LETTER '=' expr ';' {AddToTable((char)$1,(char)$3,'=');}
| expr ';'
;

expr: expr '+' expr {$$ = AddToTable((char)$1,(char)$3,'+');}
| expr '-' expr {$$ = AddToTable((char)$1,(char)$3,'-');}
| expr '*' expr {$$ = AddToTable((char)$1,(char)$3,'*');}
| expr '/' expr {$$ = AddToTable((char)$1,(char)$3,'/');}
| '(' expr ')' {$$ = (char)$2;}
| NUMBER {$$ = (char)$1;}
| LETTER {$$ = (char)$1;}
;
%%

int yyerror(char *s){
    printf("%s",s);
    // exit(0);
    return 1;
}

struct incod code[20];
int id=0;

char AddToTable(char opd1,char opd2,char opr){
    code[ind].opd1=opd1;
    code[ind].opd2=opd2;
    code[ind].opr=opr;
    ind++;
    temp++;
    return temp;
}

void printTable(){
    int cnt=0;
    while(cnt<ind){
        //printf("%c : = \t",temp);
        if(isalpha(code[cnt].opd1))
        printf("%c\t",code[cnt].opd1);
        else
        {printf("%c\t",temp);}
        printf("%c\t",code[cnt].opr);
        if(isalpha(code[cnt].opd2))
        printf("%c\t",code[cnt].opd2);
        else
        {printf("%c\t",temp);}
        printf("\n");
        cnt++;
    }
}

void TargetCode(){
    temp++;
    int cnt=0;
    printf("\n\n\t TARGET CODE\n\n");
    while(cnt<ind){
        printf("LOAD  %c\n", code[cnt].opd1);
        printf("LOAD  %c\n", code[cnt].opd2);

        switch(code[cnt].opr){
            case '+':
                printf("ADD   %c %c %c\n", temp,code[cnt].opd1, code[cnt].opd2);
                break;
            case '*':
                printf("MULT  %c %c %c\n", temp, code[cnt].opd1, code[cnt].opd2);
                break;
            case '-':
                printf("SUB   %c %c %c\n", temp,code[cnt].opd1, code[cnt].opd2);
                break;
            case '/':
                printf("DIV   %c %c %c\n", temp,code[cnt].opd1, code[cnt].opd2);
                break;
            case '=': 
                printf("MOV   %c %c\n", code[cnt].opd1, code[cnt].opd2);
                break;
        }
        temp++;
        cnt++;
    }
}

int main(){
    printf("\nEnter the Expression: ");
    yyparse();
    temp='A';
    // printTable();
    TargetCode();
    // TargetCode2();
    return 0;
}

int yywrap(){
    return 1;
}