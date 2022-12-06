from sly import Parser
from calculator_lexer import MyLexer
import numpy as np


class MyParser(Parser):
    GF = 1234577
    tokens = MyLexer.tokens
    result = []
    error = False

    precedence = (
        ('left', ADD, SUB),
        ('left', MUL, DIV),
        ('right', POW),
        ('right', UMINUS), 
    )

    def __init__(self, variables: dict = None):
        self.stack = {}

    @_('expr')
    def statement(self, p):
        print(p.expr)
        
    @_('expr2_')
    def statement(self, p):
        print(p.expr2_)
        
    @_('NUMBER')
    def expr(self, p):
        self.result.append(p.NUMBER)
        return int(p.NUMBER) % self.GF

    @_('expr ADD expr')
    def expr(self, p):
        self.result.append('+')
        return (p.expr0 + p.expr1) % self.GF

    @_('expr SUB expr')
    def expr(self, p):
        res = (p.expr0 - p.expr1) % self.GF
        if res < 0:
            res = res + self.GF
        self.result.append('-')
        return res

    @_('expr MUL expr')
    def expr(self, p):
        self.result.append('*')
        return (np.int64(p.expr0) * p.expr1) % self.GF

    @_('expr DIV expr')
    def expr(self, p):
        self.result.append('/')
        
        for i in range(0, self.GF):
            if np.int64(i) * p.expr1 % self.GF == p.expr0:
                return i
        
        self.error = True
        print(p.expr1, " nie jest odwracalne w 12345677")
        return
                
    @_('SUB expr %prec UMINUS')
    def expr(self, p):
        res = -p.expr
        while res < 0:
            res = res + self.GF;
        
        return res
    
    @_('expr POW expr2_')
    def expr(self, p):
        res = 1
        print("WRRRAAUURR ", p.expr2_)
        for i in range(0, p.expr2_):
            res = (res * p.expr) % (self.GF - 1)
        return res
        
    @_('NUMBER')
    def expr2_(self, p):
        self.result.append(p.NUMBER)
        return int(p.NUMBER) % (self.GF - 1)

    @_('expr2_ ADD expr2_')
    def expr2_(self, p):
        self.result.append('+')
        return (p.expr2_0 + p.expr2_1) % (self.GF - 1)

    @_('expr2_ SUB expr2_')
    def expr2_(self, p):
        res = (p.expr2_0 - p.expr2_1) % (self.GF - 1)
        if res < 0:
            res = res + (self.GF - 1)
        self.result.append('-')
        return res

    @_('expr2_ MUL expr2_')
    def expr2_(self, p):
        self.result.append('*')
        return (np.int64(p.expr2_0) * p.expr2_1) % (self.GF - 1)

    @_('expr2_ DIV expr2_')
    def expr2_(self, p):
        self.result.append('/')
        
        for i in range(0, self.GF - 1):
            if (np.int64(i) * p.expr2_1 % (self.GF - 1)) == p.expr2_0:
                return i
        
        self.error = True
        print(p.expr2_1, " nie jest odwracalne w 12345677")
        return
                
    @_('SUB expr2_ %prec UMINUS')
    def expr2_(self, p):
        res = -p.expr2_
        while res < 0:
            res = res + self.GF;
        
        return res

    @_('LPAREN expr RPAREN')
    def expr(self, p):
        return p.expr
    
    def error(self, t):
        print('Blad')