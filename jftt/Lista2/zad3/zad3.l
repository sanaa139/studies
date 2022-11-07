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
%%


<INITIAL>{
    "/\\\n/"        { BEGIN(single_line_comment) ;}
    "\""            { BEGIN(quote_in_string); ECHO; }
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
<single_line_comment>{
    "\\\n"          
    "\n"            { BEGIN(INITIAL); ECHO; }
    .            
}
<quote_in_string>{
    \\"\""          { ECHO; }
    "\""            { BEGIN(INITIAL); ECHO; }
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
    "\n"            { BEGIN(INITIAL); ECHO; }
    .               {
                        if(leave_doxygen_comments == 1){
                            ECHO;
                        }
                    }
}
<doxygen_2slashes_and_exclamation_comment>{
    "\n"            { BEGIN(INITIAL); ECHO; }
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

    if ( argc > 1 && ! strcmp(argv[1], "d")){
        leave_doxygen_comments = 1;
    }
    yylex();
    return 0;
}