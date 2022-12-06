all: lexer parser
	g++ -std=c++11 calculator.tab.c lex.yy.c -lfl -o calc

lexer: 
	flex input.l

parser:
	bison -d calculator.y

clean:
	rm calculator.tab.h calculator.tab.c lex.yy.c calc