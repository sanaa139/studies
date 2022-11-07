flex zad2.l
gcc lex.yy.c
cat test.py | ./a.out > test_output.py

python test_output.py > test_printed.txt