%{
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
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

// yylval is int by default
%union // modifies the type of yylval
{
	char sym;
}
// in the declarations section of the yacc input. 
// The interpretation enclosed in the angle brackets is the name of the union member you want to use. 
// The symbol is the name of a nonterminal symbol defined in the grammar rules. 
%token <sym> LETTER NUMBER
// type of non terminal expr is of sym
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
| expr '/'expr {$$ = AddToTable((char)$1,(char)$3,'/');}
| '('expr ')' {$$ = (char)$2;}
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

void ThreeAddressCode() {
	int cnt=0;
	temp++;
	printf("\n\n\t THREE ADDRESS CODE\n\n");
	while(cnt<ind) {
		printf("%c : = \t",temp);
		if(isalnum(code[cnt].opd1))
			printf("%c\t",code[cnt].opd1);
		else
			{printf("%c\t",temp);}
		printf("%c\t",code[cnt].opr);
		if(isalnum(code[cnt].opd2))
			printf("%c\t",code[cnt].opd2);
		else
			{printf("%c\t",temp);}
		printf("\n");
		cnt++;
		temp++;
		// here temp++ will make it equal to the temp in the struct code arr
		// now the new temp var are used for quadruple
	}
}
void quadraple(){
	int cnt=0;
	temp++;

	printf("\n\n\t QUADRAPLE CODE\n\n");
	while(cnt<ind){
		printf("%d",id);
		printf("\t");
		printf("%c",code[cnt].opr);
		printf("\t");
		if(isalnum(code[cnt].opd1))
			printf("%c\t",code[cnt].opd1);
		else
			{printf("else: %c\t",temp);}
		if(isalnum(code[cnt].opd2))
			printf("%c\t",code[cnt].opd2);
		else
			{printf("else: %c\t",temp);}
		printf("%c",temp);
		printf("\n");
		cnt++;
		temp++;
		id++;
	}
}
void triple(){
	int cnt=0,cnt1,id1=0;
	temp++;
	printf("\n\n\t TRIPLE CODE\n\n");
	while(cnt<ind){
		// 1st time need to print both operand 1 and 2
		if(id1==0){ 
			printf("%d",id1);
			printf("\t");
			printf(" %c",code[cnt].opr);
			printf("\t");
			if(isalnum(code[cnt].opd1))
				printf(" %c\t",code[cnt].opd1);
			else
				{printf("%c\t",temp);}
			cnt1=cnt-1;
			if(isalnum(code[cnt].opd2))
				printf(" %c",code[cnt].opd2);
			else
				{printf("%c\t",temp);}
		}
		else{
			printf("%d",id1);
			printf("\t");
			printf(" %c",code[cnt].opr);
			printf("\t");
			if(code[cnt].opd1>='A' && code[cnt].opd1<='Z')
				printf("(%d)\t",code[cnt].opd1-'B');
			else
				{printf(" %c\t",code[cnt].opd1);}
			cnt1=cnt-1;
			if(code[cnt].opd2>='A' && code[cnt].opd2<='Z')
				printf("(%d)\t",code[cnt].opd2-'B');
			else
				{printf(" %c\t",code[cnt].opd2);}
		}
		printf("\n");
		cnt++;
		temp++;
		id1++;
	}
}

int yywrap(void){
	return 1;
}

int main(){
	printf("\nEnter the Expression: "); 
	yyparse();
	// for(int i=0; i<ind; i++){
	// 	printf("%c\t%c\t%c\n", code[i].opd1, code[i].opd2, code[i].opr);
	// }
	// after assigning temp variable to store in arr of struct code 
	// we again initialize temp = 'A' to print more temp var for quadraple
	temp='A';
	ThreeAddressCode();
	temp='A';
	quadraple();
	temp='A';
	triple();
	return 0;
}

