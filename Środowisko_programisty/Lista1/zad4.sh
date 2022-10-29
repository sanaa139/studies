#/bin/bash

dir=$1

unikalneSlowa=$( ./zad3.sh $dir )

for word in $unikalneSlowa; do
    #${string:position:length}
    if [ ${word:0:1} != ":" ]; then
        echo $word:
        grep -rnE '(^| )'$word'($| )' $dir
        
    fi
done;