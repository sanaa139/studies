%{
    #include <iostream>
    #include <math.h>
    #include <string>
    #include <vector>
    #define GF 1234577
    void yyerror(std::string s);
    int yylex();
    int power(int a, int pow);
    std::vector<std::string> reversePolishNotation;
    bool error = false;
%}

%token NUMBER ERROR
%left '-' '+'
%left '*' '/'
%left NEG
%right '^'

%%
input:    
    | input line
;

line:     '\n'
        | exp '\n'  { 
                        if(error == false){
                            printf("= %d\n", $1);
                            for(int i = 0; i < reversePolishNotation.size(); i++){
                                std::cout << reversePolishNotation[i] << " ";
                            }
                            std::cout << std::endl;
                        }
                        error = false; 
                        reversePolishNotation.clear();
                    }
        | error '\n' { yyerrok;                  }
;

exp:      NUMBER             { 
                                $$ = $1 % GF;
                                reversePolishNotation.push_back(std::to_string($1));
                             }
        | exp '+' exp        { 
                                $$ = ($1 + $3) % GF;    
                                reversePolishNotation.push_back("+");
                             }
        | exp '-' exp        { 
                                int res = ($1 - $3) % GF;
                                if(res < 0){
                                    $$ = res + GF;
                                }else{
                                    $$ = res;
                                }
                                reversePolishNotation.push_back("-");
                             }
        | exp '*' exp        { 
                                $$ = (int)(((long long)$1 * $3) % GF);  
                                reversePolishNotation.push_back("*");
                             }
        | exp '/' exp        { 
                                int f = 0;
                                reversePolishNotation.push_back("/");
                                for(int i = 0; i < GF; i++){
                                    if((int)(((long long)i * $3) % GF) == $1){
                                        f = 1;
                                        $$ = i;
                                        break;
                                    }
                                } 
                            
                                if(f == 0){
                                    error = true;
                                    yyerror(std::to_string($3) + " nie jest odwracalne modulo 12345677");
                                }
                            
                             }
        | exp '^' exp2       {  
                                long long res = 1;
                                for(int i = 0; i < $3; i++){
                                    res = (res * $1) % GF;
                                }
                                $$ = (int)res;
                                reversePolishNotation.push_back("^");
                             }
        | '(' exp ')'        { $$ = $2; }
        | '-' exp  %prec NEG { 
                                int res = -$2;
                                while(res < 0){
                                    res = res + GF;
                                }
                                $$ = res;
                                if(reversePolishNotation.back() != "*" && reversePolishNotation.back() != "/" &&
                                    reversePolishNotation.back() != "+" && reversePolishNotation.back() != "-" && reversePolishNotation.back() != "^"){
                                    reversePolishNotation.pop_back();
                                    reversePolishNotation.push_back(std::to_string(res));
                                }
                             }
;

exp2:
        NUMBER             { 
                                $$ = $1 % (GF - 1);
                                reversePolishNotation.push_back(std::to_string($1));
                             }
        | exp2 '+' exp2        { 
                                $$ = ($1 + $3) % (GF - 1);    
                                reversePolishNotation.push_back("+");
                             }
        | exp2 '-' exp2       { 
                                int res = ($1 - $3) % (GF - 1);
                                if(res < 0){
                                    $$ = res + (GF - 1);
                                }else{
                                    $$ = res;
                                }
                                reversePolishNotation.push_back("-");
                             }
        | exp2 '*' exp2        { 
                                $$ = (int)(((long long)$1 * $3) % (GF - 1));    
                                reversePolishNotation.push_back("*");
                             }
        | exp2 '/' exp2        { 
                                reversePolishNotation.push_back("/");
                                int f = 0;
                                for(int i = 0; i < (GF - 1); i++){
                                    if((int)(((long long)i * $3) % (GF - 1)) == $1){
                                        f = 1;
                                        $$ = i;
                                        break;
                                    }
                                } 
                                if(f == 0){
                                    error = true;
                                    yyerror(std::to_string($3) + " nie jest odwracalne modulo 12345676");
                                }
                             }
        | '(' exp2 ')'        { $$ = $2; }
        | '-' exp2  %prec NEG { 
                                int res = -$2;
                                while(res < 0){
                                    res = res + (GF - 1);
                                }
                                $$ = res;
                                reversePolishNotation.pop_back();
                                reversePolishNotation.push_back(std::to_string(res));
                              }

;
%%

void yyerror(std::string s){
    std::cout << "Błąd: " << s << std::endl;
}


int main()
{
    yyparse();
    return 0;
}