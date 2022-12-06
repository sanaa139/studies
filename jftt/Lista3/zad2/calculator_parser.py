from sly import Parser
from calculator_lexer import MyLexer

class MyParser(Parser):
    GF = 1234577
    tokens = MyLexer.tokens
    result = []
    error = False

    precedence = (
        ('left', ADD, SUB),
        ('left', MUL, DIV),
        ('right', UMINUS), 
        ('right', POW),
    )

    def __init__(self, variables: dict = None):
        self.stack = {}

    @_('expr')
    def statement(self, p):
        print(p.expr)
        
    @_('NUMBER')
    def expr(self, p):
        self.result.append(p.NUMBER)
        return int(p.NUMBER) % self.GF

    @_('expr ADD expr')
    def expr(self, p):
        self.result.append('+')
        return add(p.expr0, p.expr1, self.GF)

    @_('expr SUB expr')
    def expr(self, p):
        self.result.append('-')
        return substract(p.expr0, p.expr1, self.GF)

    @_('expr MUL expr')
    def expr(self, p):
        self.result.append('*')
        return multiply(p.expr0, p.expr1, self.GF)

    @_('expr DIV expr')
    def expr(self, p):
        self.result.append('/')
        
        res = divide(p.expr0, p.expr1, self.GF)
        if(res != -1):
            return res
        
        self.error = True
        print(p.expr1, " nie jest odwracalne w 12345677")
        return None
                
    @_('SUB expr %prec UMINUS')
    def expr(self, p):
        return uminus(p.expr, self.GF)
    
    @_('expr POW expr2_')
    def expr(self, p):
        if(p.expr2_ == -1):
            return None
        res = 1
        for i in range(0, p.expr2_):
            res = multiply(res,p.expr, self.GF)
        return res
        
    @_('NUMBER')
    def expr2_(self, p):
        self.result.append(p.NUMBER)
        return int(p.NUMBER) % (self.GF - 1)

    @_('expr2_ ADD expr2_')
    def expr2_(self, p):
        self.result.append('+')
        return add(p.expr2_0, p.expr2_1, self.GF - 1)

    @_('expr2_ SUB expr2_')
    def expr2_(self, p):
        self.result.append('-')
        return substract(p.expr2_0, p.expr2_1, self.GF - 1)

    @_('expr2_ MUL expr2_')
    def expr2_(self, p):
        self.result.append('*')
        return multiply(p.expr2_0, p.expr2_1, self.GF - 1)

    @_('expr2_ DIV expr2_')
    def expr2_(self, p):
        self.result.append('/')
        
        res = divide(p.expr2_0, p.expr2_1, self.GF - 1)
        if(res != -1):
            return res
        
        self.error = True
        print(p.expr2_1, " nie jest odwracalne w 12345677")
        return None
                
    @_('SUB expr2_ %prec UMINUS')
    def expr2_(self, p):
        return uminus(p.expr2_, self.GF - 1)

    @_('LPAREN expr RPAREN')
    def expr(self, p):
        return p.expr
    
    @_('LPAREN expr2_ RPAREN')
    def expr2_(self, p):
        return p.expr2_

    def error(self, t):
        print('Blad')
        
def add(a, b, P):
    return (a + b) % P

def substract(a, b, P):
    res = (a - b) % P
    while res < 0:
        res = res + P
    return res

def multiply(a, b, P):
    return (a * b) % P

def divide(a, b, P):
    for i in range(0, P):
        if ((i * b) % P) == a:
            return i
    return -1

def uminus(a, P):
    res = -a
    while res < 0:
        res = res + P;
    
    return res