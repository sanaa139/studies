%{
    int leave_doxygen_comments = 0;
%}

%x doxygen_slash_and_2_stars_comment
%x doxygen_slash_and_star_and_exclamation_comment
%x doxygen_3slashes_comment
%x doxygen_2slashes_and_exclamation_comment
%x quote_in_string
%x single_line_comment
%x multiline_comment
%x directive
%%


<INITIAL>{
    "\#include"[ \t]* { 
                        ECHO; 
                        BEGIN(directive); 
                    }
    "/\\\n/"        { BEGIN(single_line_comment); }
    "\""            {
                        ECHO;
                        BEGIN(quote_in_string);
                    }
    "/**"           {
                        if(leave_doxygen_comments == 1){
                            ECHO;
                        }
                        BEGIN(doxygen_slash_and_2_stars_comment);
                    }
    "/*!"           {
                        if(leave_doxygen_comments == 1){
                            ECHO;
                        }
                        BEGIN(doxygen_slash_and_star_and_exclamation_comment);
                    }
    "///"           {
                        if(leave_doxygen_comments == 1){
                            ECHO;
                        }
                        BEGIN(doxygen_3slashes_comment);
                    }
    "//!"           {
                        if(leave_doxygen_comments == 1){
                            ECHO;
                        }
                        BEGIN(doxygen_2slashes_and_exclamation_comment);
                    }
    "//"            { BEGIN(single_line_comment); }
    "/*"            { BEGIN(multiline_comment); }
}
<directive>{
    > {ECHO; BEGIN(INITIAL);}
}
<single_line_comment>{
    "\\\n"          
    "\n"            {
                        ECHO;
                        BEGIN(INITIAL);
                    }
    .            
}
<quote_in_string>{
    \\"\""          { ECHO; }
    "\""            { 
                        ECHO;
                        BEGIN(INITIAL);
                    }
}
<doxygen_slash_and_2_stars_comment>{
    .               {
                        if(leave_doxygen_comments == 1){
                            ECHO;
                        }
                    }
    "*/"            {
                        if(leave_doxygen_comments == 1){
                            ECHO;
                        }
                        BEGIN(INITIAL);
                    }
}
<doxygen_slash_and_star_and_exclamation_comment>{
    .               {
                        if(leave_doxygen_comments == 1){
                            ECHO;
                        }
                    }
    "*/"            {
                        if(leave_doxygen_comments == 1){
                            ECHO;
                        }
                        BEGIN(INITIAL);
                    }
}
<doxygen_3slashes_comment>{
    "\n"            { 
                        ECHO;
                        BEGIN(INITIAL);
                    }
    .               {
                        if(leave_doxygen_comments == 1){
                            ECHO;
                        }
                    }
}
<doxygen_2slashes_and_exclamation_comment>{
    "\n"            { 
                        ECHO;
                        BEGIN(INITIAL);
                    }
    .               {
                        if(leave_doxygen_comments == 1){
                            ECHO;
                        }
                    }
}
<multiline_comment>{
    "*/"            { BEGIN(INITIAL); }
    .               
}

%%
  
int yywrap(){}
int main(int argc, char ** argv){

    if ( argc > 1 && !strcmp(argv[1], "d")){
        leave_doxygen_comments = 1;
    }
    yylex();
    return 0;
}