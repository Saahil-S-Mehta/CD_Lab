%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<ctype.h>
    struct incod{
        char op1;
        char op2;
        char op;
    } tac[10];
    char toTAC(char a, char b, char c);
    char temp = 'A';
    int ct = 0;
%}

%union{
    char sym;
}

%token <sym> num id plus minus mult divi assign
%type <sym> E T
%left plus minus 
%left mult divi

%%
E : id assign T ';' {toTAC((char)$1,(char)$3, (char)$2);}
| T ';'
;
T : T plus T {$$ = toTAC((char)$1, (char)$3, (char)$2);}
| T minus T {$$ = toTAC((char)$1, (char)$3, (char)$2);}
| T mult T {$$ = toTAC((char)$1, (char)$3, (char)$2);}
| T divi T {$$ =  toTAC((char)$1, (char)$3, (char)$2);}
| '(' T ')' {$$ = (char)$2;}
| num {$$ = (char)$1;}
| id {$$ = (char)$1;}
;
%%

char toTAC(char a, char b, char c){
    //printf("%c %c %c \n", a, c, b);
    tac[ct].op1 = a;
    tac[ct].op2 = b;
    tac[ct].op = c;
    ++ct;
    return temp++;
}

void showTAC(){
    char var = 'A';
    for(int i = 0; i < ct; i++, var++){
        printf("%c : = %c\t%c\t%c\n", var, tac[i].op1, tac[i].op, tac[i].op2);
    }
}

void quadruple(){
    char st = 'A';
    for(int i = 0; i < ct; i++){
        printf("%d\t%c\t%c\t%c\t%c\t\n", i, tac[i].op, tac[i].op1, tac[i].op2, st++);
    }
}

void triple(){
    char st = 'A';
    for(int i = 0; i < ct; i++){

        printf("%d\t%c\t", i, tac[i].op);
        if(isupper(tac[i].op1)){
            printf("(%d)\t", tac[i].op1-'A');
        }
        else{
            printf("%c\t", tac[i].op1);
        }
        if(isupper(tac[i].op2)){
            printf("(%d)\n", tac[i].op2-'A');
        }
        else{
            printf("%c\n", tac[i].op2);
        }
    }
}

void targetCode(){

    char st = 'A', var = 'R';
    for(int i = 0; i < ct; i++){
        char op1 = tac[i].op1;
        char op2 = tac[i].op2;
        char op = tac[i].op;
        if(!isupper(tac[i].op1)){
            op1 = var++;
            printf("LOAD\t%c\t%c \n", op1, tac[i].op1);
        }
        if(!isupper(tac[i].op2)){
            op2 = var++;
            printf("LOAD\t%c\t%c \n", op2, tac[i].op2);
        }
        
        if(tac[i].op == '+'){
            printf("ADD\t%c\t%c\t%c \n", st, op1, op2);
        }
        else if(tac[i].op == '-'){
            printf("SUB\t%c\t%c\t%c \n", st, op1, op2);
        }
        else if(tac[i].op == '/'){
            printf("DIV\t%c\t%c\t%c \n", st, op1, op2);
        }
        else if(tac[i].op == '*'){
            printf("MULT\t%c\t%c\t%c \n", st, op1, op2);
        }
        st++;
    }
}

int main(){
    printf("Enter the expression: ");
    yyparse();
    printf("\n THREE ADDRESS CODE\n");
    showTAC();
    printf("\n QUADRUPLE \n");
    quadruple();
    printf("\n TRIPLE \n");
    triple();
    printf("\n TARGET CODE \n");
    targetCode();
    return 0;
}

int yyerror(){
    printf("There is an error \n");
    exit(1);
}