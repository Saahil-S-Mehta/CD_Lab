#include<stdio.h>
#include<stdlib.h>
#include<string.h>
char exp1[30],stack[30],arr[30],temp[30];
int i,j,k,l,r;

void push() {
	arr[i]=exp1[k];
	i++;
}

void dispinp() {	// display the input string remaining
	printf("\t\t\t");
	for(k=0;k<strlen(exp1);k++)
		printf("%c",exp1[k]); 
	printf("$");
}

void dispstk() {	// display the stack ele
	printf("\n");
	for(k=0;k<strlen(stack);k++)
		printf("%c",stack[k]);
}

void assign() {		// shifting input char to stack
	stack[++j]=arr[i];
	exp1[i]=' ';
	dispstk();
	dispinp();
}

int main() {

	printf("\t\t\tSHIFT REDUCE PARSER\n");
	printf("\nThe Production is: E->E+E/E*E/E-E/i\n");
	printf("\nEnter the string to be parsed:\n");
	gets(exp1);

	printf("\nSTACK\t\t\tINPUT\t\t\tACTION\n");

	printf("\n$");
	dispinp();
	printf("\t\t\tShift");
	
	for(k=0;k<strlen(exp1);k++) // making a copy of input exp1 into arr
		push();				// as input exp1 array is changed
	
	l=strlen(exp1);
	stack[0]='$';
	for(i=0;i<l;i++) {
		switch(arr[i])
		{
			case 'i': 
				assign();
				printf("\t\t\tReduce by E->i");
				stack[j]='E';
				dispstk();
				dispinp();
				if(arr[i+1]!='\0')
					printf("\t\t\tShift");
				break;
			case '+': 
				assign();
				printf("\t\t\tShift");
				break;
			case '*': 
				assign();
				printf("\t\t\tShift");
				break;
			case '-': 
				assign();
				printf("\t\t\tShift");
				break;
			default: 
				printf("\nError:String not accepted\n");
				return 0;
		}
	}

	l=strlen(stack);
	while(l>2) { // accept when $E in stack?
		
		r=0;
		for(i=l-1;i>=l-3;i--){ // select the last 3 char of stack
			temp[r]=stack[i];
			r++;
		}
		temp[r]=NULL;

		if((strcmp(temp,"E+E")==0)||(strcmp(temp,"E*E")==0)||(strcmp(temp,"E-E")==0)) {
			for(i=l-1;i>l-3;i--)
				stack[i]=' ';
			stack[l-3]='E';
			printf("\t\t\tReduce by E->");
			for(i=0;i<strlen(temp);i++)
				printf("%c",temp[i]);
			dispstk();
			dispinp(); 
			l=l-2;
		}
		else{
			printf("\nError:String not accepted\n"); 
			return 0;
		}
	}
	printf("\t\t\tAccept"); 
	printf("\n\nString accepted\n");
	return 0;
}

/*
////////////////////////////// Example 1 //////////////////////////////

			SHIFT REDUCE PARSER

The Production is: E->E+E/E*E/E-E/i

Enter the string to be parsed:
i+i

STACK			INPUT			ACTION

$			i+i$			Shift
$i			 +i$			Reduce by E->i
$E			 +i$			Shift
$E+			  i$			Shift
$E+i			   $			Reduce by E->i
$E+E			   $			Reduce by E->E+E
$E   			   $			Accept

String accepted

////////////////////////////// Example 2 //////////////////////////////

			SHIFT REDUCE PARSER

The Production is: E->E+E/E*E/E-E/i

Enter the string to be parsed:
i+i*i

STACK			INPUT			ACTION

$			i+i*i$			Shift
$i			 +i*i$			Reduce by E->i
$E			 +i*i$			Shift
$E+			  i*i$			Shift
$E+i			   *i$			Reduce by E->i
$E+E			   *i$			Shift
$E+E*			    i$			Shift
$E+E*i			     $			Reduce by E->i
$E+E*E			     $			Reduce by E->E*E
$E+E   		     $			Reduce by E->E+E
$E     		     $			Accept

String accepted

////////////////////////////// Example 3 //////////////////////////////

			SHIFT REDUCE PARSER

The Production is: E->E+E/E*E/E-E/i

Enter the string to be parsed:
i+-i

STACK			INPUT			ACTION

$			i+-i$			Shift
$i			 +-i$			Reduce by E->i
$E			 +-i$			Shift
$E+			  -i$			Shift
$E+-			   i$			Shift
$E+-i			    $			Reduce by E->i
$E+-E			    $
Error:String not accepted


*/
