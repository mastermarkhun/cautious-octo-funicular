#!/bin/bash
#description=Clean deleted movies' folders.
#foregroundOnly=false
#backgroundOnly=false
#arrayStarted=true
#name=Movies Clean
#argumentDescription=
#argumentDefault=

echo "-Starting..."

IFS=$'\n'
folders="$( ls -A1 -d /mnt/disk*/downloads/Filmek/*/ )"

for dir in $folders; do
    files=$( ls "$dir" )
    count=$(echo "$files" | sed '/^\s*$/d' | wc -l)
    #echo "-$count-$dir-"
    if [ "$count" -eq "1" ]; then
        if [[ "$files" == *".srt" ]]; then
            rm -rf "$dir"
            echo "-deleted---$dir-"
        fi
    elif [ "$count" -eq "0" ]; then
        rm -rf "$dir"
        echo "-empty---$dir-"
    fi
done

echo "-Ended..."