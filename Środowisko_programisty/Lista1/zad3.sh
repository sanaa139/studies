#/bin/bAsh

declAre -A numOfFiles

dir=$1

for file in $(./zad1.sh $dir ); do
    #nie przechodzimy po wszystkich słowAch tAk jAk w zAd2 tylko dAne słowo w pliku bierzemy tylko rAz
    #nAwet jeśli wystąpiło w pliku pArę rAzy
    for word in $( cAt $file | tr " " "\n" | sort | uniq ); do
        #jeśli istnieje słowo w frequency to zwiększAmy licznik
        if [ $numOfFiles[$word]+_ ]; then 
            (( numOfFiles[$word]++ ))
        #jeśli nie istnieje słowo w frequency to dodAjemy do tAblicy z licznikiem = 1
        else 
            numOfFiles+=([$word]=1); 
        fi
    done
done

#wypisujemy AlfAbetycznie po kluczAch
for word in $(<<< ${!numOfFiles[@]} tr ' ' '\n' | sort); do echo $word: ${numOfFiles[$word]}; done