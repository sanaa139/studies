%{
    #define stack_size 100
    int stack[stack_size];
    int argLeft, argRight;
    int ptr = 0;

    int popFromTheStack(){
        ptr--;
        if(ptr < 0){
            printf("\nERROR: Za mała liczba argumentów\n");
            exit(0);
        }
        return stack[ptr];
    }

    void pushToTheStack(int number){
        stack[ptr] = number;
        if(ptr < stack_size-1){
            ptr++;
        } else {
            printf("\nERROR: Przepelniony stos\n");
            exit(0);
        }
    }

    void print_result(){
        if(ptr > 1){
            printf("\nERROR: Za mała liczba operatorów\n");
            exit(0);
        }
        printf("\n= %d\n", popFromTheStack());
    }
%}

%x ERROR
%%

"-"*[0-9]+          {
                        ECHO; 
                        pushToTheStack(atoi(yytext));
                    }

" "                 {
                        ECHO;
                    }
[^0-9\+\-\*\^/%\n ] {
                        printf("\nERROR: zly symbol %s \n", yytext);
                        ECHO;
                        BEGIN(ERROR);
                    }

\+                  {
                        ECHO;
                        argRight = popFromTheStack();
                        argLeft = popFromTheStack();
                        pushToTheStack(argLeft + argRight);
                    }
\-                   {
                        ECHO;
                        argRight = popFromTheStack();
                        argLeft = popFromTheStack();
                        pushToTheStack(argLeft - argRight);
                    }

\*                  {
                        ECHO;
                        argRight = popFromTheStack();
                        argLeft = popFromTheStack();
                        pushToTheStack(argLeft * argRight);
                    }

\^                  {
                        ECHO;
                        argRight = popFromTheStack();
                        if(argRight < 0){
                            printf("\nERROR: Wykladnik nie moze byc ujemny\n");
                            BEGIN(ERROR);
                        }else{
                            argLeft = popFromTheStack();
                            int result = 1;
                            for(int i = 0; i < argRight; i++){
                                result *= argLeft;
                            }
                            pushToTheStack(result);
                        }
                    }

\/                  {
                        ECHO;
                        argRight = popFromTheStack();
                        if(argRight == 0) {
                            printf("\nERROR: Dzielenie przez 0\n");
                            BEGIN(ERROR);
                        }else{
                            argLeft = popFromTheStack();
                            pushToTheStack(argLeft / argRight);
                        }
                    }

\%                  {
                        ECHO;
                        argRight = popFromTheStack();
                        if(argRight == 0) {
                            printf("\nERROR: Dzielenie przez 0%%)\n");
                            BEGIN(ERROR);
                        }else{
                            argLeft = popFromTheStack();
                            pushToTheStack(argLeft % argRight);
                        }
                    }
\n                  { print_result(); ptr = 0; }

<ERROR>{
    .
    \n              {
                        ptr = 0;
                        BEGIN(INITIAL);
                    }
}

%%
  
int yywrap(){}
int main(){
      yylex();
      return 0;
}