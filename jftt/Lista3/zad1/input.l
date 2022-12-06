%{
    # include "calculator.tab.h"
%}

%%
"+"    { return '+'; }
"-"    { return '-'; }
"*"    { return '*'; }
"/"    { return '/'; }
"^"    { return '^'; }
"("    { return '('; }
")"    { return ')'; }
[0-9]+ { 
             yylval = atoi(yytext);
             return (NUMBER); 
        }
\n     { return '\n'; }
[ \t]  
#(.|\\\n)*\n
\\\n 
.   {return ERROR; }
%%