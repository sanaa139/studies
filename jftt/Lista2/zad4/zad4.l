%{
    #define stack_size 100
    int stack[stack_size];
    int argLeft, argRight;
    int ptr = 0;
    int error = 0;
    int noarguments = 0;

    int popFromTheStack(){
        ptr--;
        if(ptr < 0){
            printf("\nERROR: Za mała liczba argumentów\n");
            error = 1;
            noarguments = 1;
        }
        return stack[ptr];
    }

    void pushToTheStack(int number){
        stack[ptr] = number;
        if(ptr < stack_size-1){
            ptr++;
        } else {
            printf("\nERROR: Przepelniony stos\n");
            error = 1;
        }
    }

    void print_result(){
        if(ptr > 1){
            printf("\nERROR: Za mała liczba operatorów\n");
            error = 1;
        }else{
            int x = popFromTheStack();
            if(noarguments == 0){
                printf("\n= %d\n", x);
            }
        }
    }
%}

%x ERROR
%%

"-"*[0-9]+          {
                        
                        pushToTheStack(atoi(yytext));
                        if(error){
                            BEGIN(ERROR);
                        }
                    }

" "                 {
                        
                    }
[^0-9\+\-\*\^/%\n ] {
                        
                        printf("\nERROR: zly symbol %s \n", yytext);
                        BEGIN(ERROR);
                    }

\+                  {
                        
                        argRight = popFromTheStack();
                        argLeft = popFromTheStack();
                        if(error){
                            BEGIN(ERROR);
                        }
                        pushToTheStack(argLeft + argRight);
                        if(error){
                            BEGIN(ERROR);
                        }
                    }
\-                  {
                        
                        argRight = popFromTheStack();
                        argLeft = popFromTheStack();
                        if(error){
                            BEGIN(ERROR);
                        }
                        pushToTheStack(argLeft - argRight);
                        if(error){
                            BEGIN(ERROR);
                        }
                    }

\*                  {
                        
                        argRight = popFromTheStack();
                        argLeft = popFromTheStack();
                        if(error){
                            BEGIN(ERROR);
                        }
                        pushToTheStack(argLeft * argRight);
                        if(error){
                            BEGIN(ERROR);
                        }
                    }

\^                  {
                    
                        argRight = popFromTheStack();
                        if(error){
                            BEGIN(ERROR);
                        }
                        else if(argRight < 0){
                            printf("\nERROR: Wykladnik nie moze byc ujemny\n");
                            BEGIN(ERROR);
                        }else{
                            argLeft = popFromTheStack();
                            if(error){
                                BEGIN(ERROR);
                            }
                            int result = 1;
                            for(int i = 0; i < argRight; i++){
                                result *= argLeft;
                            }
                            pushToTheStack(result);
                            if(error){
                                BEGIN(ERROR);
                            }
                        }
                    }

\/                  {
                    
                        argRight = popFromTheStack();
                        if(error){
                            BEGIN(ERROR);
                        }
                        else if(argRight == 0) {
                            printf("\nERROR: Dzielenie przez 0\n");
                            BEGIN(ERROR);
                        }else{
                            argLeft = popFromTheStack();
                            if(error){
                                BEGIN(ERROR);
                            }
                            pushToTheStack(argLeft / argRight);
                            if(error){
                                BEGIN(ERROR);
                            }
                        }
                    }

\%                  {
            
                        argRight = popFromTheStack();
                        if(error){
                            BEGIN(ERROR);
                        }
                        else if(argRight == 0) {
                            printf("\nERROR: Dzielenie przez 0%%\n");
                            BEGIN(ERROR);
                        }else{
                            argLeft = popFromTheStack();
                            if(error){
                                BEGIN(ERROR);
                            }
                            pushToTheStack(argLeft % argRight);
                            if(error){
                                BEGIN(ERROR);
                            }
                        }
                    }
\n                  {   print_result(); ptr = 0; noarguments = 0; }

<ERROR>{
    .   
    \n              {
                        ptr = 0;
                        error = 0;
                        BEGIN(INITIAL);
                    }
}

%%
  
int yywrap(){}
int main(){
      yylex();
      return 0;
}