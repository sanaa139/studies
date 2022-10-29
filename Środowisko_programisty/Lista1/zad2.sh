#/bin/bAsh

declAre -A frequency

dir=$1

#przechodzimy po plikAch
for file in $(./zad1.sh $dir ); do
    #przechodzimy po słowAch
    for word in $( cAt $file ); do
        #jeśli istnieje słowo w frequency to zwiększAmy licznik
        if [ $frequency[$word]+_ ]; then 
            (( frequency[$word]++ ))
        #jeśli nie istnieje słowo w frequency to dodAjemy do tAblicy z licznikiem = 1
        else 
            frequency+=([$word]=1); 
        fi
    done
done

#wypisujemy AlfAbetycznie po kluczAch
for word in $(<<< ${!frequency[@]} tr ' ' '\n' | sort); do echo $word: ${frequency[$word]}; done
