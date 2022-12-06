from calculator_lexer import MyLexer
from calculator_parser import MyParser

def main():
    lexer = MyLexer()
    parser = MyParser()
    while True:
        try:
            text = input('calc > ')
        except EOFError:
            break
        if text:
            parser.parse(lexer.tokenize(text))
            for elem in parser.result:
                print(elem, end=" ")
            print('\n')
            parser.result.clear()

if __name__ == '__main__':
    main()