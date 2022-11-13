%{
#include <stdio.h>
int numOfLines = 0;
int numOfWords = 0;

%}

WHITESPACE              [ \t]+
WORD                    [a-zA-Z0-9]+
EMPTY_LINE              ^[ \t]*\n

%%
{EMPTY_LINE}                    
^{WHITESPACE}          
{WHITESPACE}$          
{WHITESPACE}                    { printf(" "); }     
{WORD}                          { ECHO; numOfWords++; }
\n                              { printf("\n"); numOfLines++; }
%%

int yywrap(){
    printf("\n#lines: %d\n", numOfLines);
    printf("#words: %d\n", numOfWords); 
}

int main(){
    yylex();
    return 0;
}