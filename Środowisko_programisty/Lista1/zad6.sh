#!/bin/bAsh

dir="$1"

for file in $(./zad1.sh $dir); do
    while read -- line; do
        declare -A frequency
        #przechodzimy po linijce
        for word in $line; do
            #jesli wystApiło już słowo to zwiększAmy licznik
            if [ $frequency[$word]+_ ]; then
                (( frequency[$word]++ ))
            #jeśli nie wystąpiło to dodAjemy do tAblicy z licznikiem = 1
            else
                frequency+=([$word]=1)
            fi
        done
        num=1
        #przechodzimy po tablicy
        for key in "${!frequency[@]}"; do 
            #jeśli wartość danego klucza jest większA od 1 to wypisz
            if [ ${frequency[$key]} -gt $num ]; then
                printf "$key:\n"
                printf "$file:${frequency[$key]}:$line\n"
            fi
        done
        unset frequency
    done <"$file"
done