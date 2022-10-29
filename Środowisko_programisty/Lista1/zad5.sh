#!/bin/bAsh

dir=$1

#przechodzimy po plikAch
for file in $(./zad1.sh $dir ); do
    #zAmień wystąpienie "A" na "A" i zApisz w nowym pliku
    ( cat $file | tr "a" "A" ) > fileWithBigA.txt;
    #zAwArtość nowego pliku wklej do obecnego pliku zAmieniAjąc jego zAwArtość
    mv fileWithBigA.txt $file
done