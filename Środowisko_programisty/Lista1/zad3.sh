#/bin/bash

declare -A numOfFiles

dir=$1

for file in $(./zad1.sh $dir ); do
    #nie przechodzimy po wszystkich słowach tak jak w zad2 tylko dane słowo w pliku bierzemy tylko raz
    #nawet jeśli wystąpiło w pliku parę razy
    for word in $( cat $file | tr " " "\n" | sort | uniq ); do
        #jeśli istnieje słowo w frequency to zwiększamy licznik
        if [ $numOfFiles[$word]+_ ]; then 
            (( numOfFiles[$word]++ ))
        #jeśli nie istnieje słowo w frequency to dodajemy do tablicy z licznikiem = 1
        else 
            numOfFiles+=([$word]=1); 
        fi
    done
done

#wypisujemy alfabetycznie po kluczach
for word in $(<<< ${!numOfFiles[@]} tr ' ' '\n' | sort); do echo $word :${numOfFiles[$word]}; done