%{
%}

%x double_quotation
%x double_quotation
%x three_double_quotation
%x comment

q1  \'
q2  \"
q3  \"\"\"

%%

{q1}                    { ECHO;BEGIN(single_quotation); }
{q2}                    { ECHO;BEGIN(double_quotation); }
{q3}                    { ECHO;BEGIN(three_double_quotation); }
#                       { BEGIN(comment); }

<single_quotation>{
    \\{q1}              { ECHO; }                 /* gdy napotkamy w stringu \' */
    {q1}                { ECHO;BEGIN(INITIAL); }
}

<double_quotation>{
    \\{q2}              { ECHO; }                 /* gdy napotkamy w stringu \" */
    {q2}                { ECHO;BEGIN(INITIAL); }
}

<three_double_quotation>{
    \\{q3}              { ECHO; }                 /* gdy napotkamy w stringu \"\"\" */
    {q3}                { ECHO;BEGIN(INITIAL); }
}

<comment>{
    "\n"                { BEGIN(INITIAL); ECHO; }
    .           
}

%%
  
int yywrap(){}
int main(){
    yylex();
    return 0;
}