#!/bin/bash

dir="$1"

for file in $(./zad1.sh $dir); do
    while read -- line; do
        declare -A frequency
        #przechodzimy po linijce
        for word in $line; do
            #jesli wystapiło już słowo to zwiększamy licznik
            if [ $frequency[$word]+_ ]; then
                (( frequency[$word]++ ))
            #jeśli nie wystąpiło to dodajemy do tablicy z licznikiem = 1
            else
                frequency+=([$word]=1)
            fi
        done
        num=1
        #przechodzimy po tablicy
        for key in "${!frequency[@]}"; do 
            #jeśli wartość danego klucza jest większa od 1 to wypisz
            if [ ${frequency[$key]} -gt $num ]; then
                printf "$key:\n"
                printf "$file:${frequency[$key]}:$line\n"
            fi
        done
        unset frequency
    done <"$file"
done