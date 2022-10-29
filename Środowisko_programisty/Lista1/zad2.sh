#/bin/bash

declare -A frequency

dir=$1

#przechodzimy po plikach
for file in $(./zad1.sh $dir ); do
    #przechodzimy po słowach
    for word in $( cat $file ); do
        #jeśli istnieje słowo w frequency to zwiększamy licznik
        if [ $frequency[$word]+_ ]; then 
            (( frequency[$word]++ ))
        #jeśli nie istnieje słowo w frequency to dodajemy do tablicy z licznikiem = 1
        else 
            frequency+=([$word]=1); 
        fi
    done
done

#wypisujemy alfabetycznie po kluczach
for word in $(<<< ${!frequency[@]} tr ' ' '\n' | sort); do echo $word: ${frequency[$word]}; done
