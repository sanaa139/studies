#!/bin/bash

dir=$1

#przechodzimy po plikach
for file in $(./zad1.sh $dir ); do
    #zamień wystąpienie "a" na "A" i zapisz w nowym pliku
    ( cat $file | tr "a" "A" ) > fileWithBigA.txt;
    #zawartość nowego pliku wklej do obecnego pliku zamieniając jego zawartość
    mv fileWithBigA.txt $file
done