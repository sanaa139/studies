from sly import Lexer

class MyLexer(Lexer):
    # Set of token names.   This is always required
    tokens = { NUMBER, ADD, SUB, MUL,
               DIV, POW, LPAREN, RPAREN,}

    ignore = ' \t'
    
    ignore_comment = r'.*\#.*'

    # Regular expression rules for tokens

    NUMBER  = r'\d+'
    ADD    = r'\+'
    SUB   = r'-'
    MUL   = r'\*'
    DIV  = r'/'
    POW = r'\^'
    LPAREN  = r'\('
    RPAREN  = r'\)'