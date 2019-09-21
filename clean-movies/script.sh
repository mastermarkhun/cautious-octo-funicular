#!/bin/bash
#description=Clean deleted empty folders.
#foregroundOnly=false
#backgroundOnly=false
#arrayStarted=true
#name=Clean Empty Folders
#argumentDescription=
#argumentDefault=

echo "Starting..."

IFS=$'\n'
movies="/mnt/disks/downloads/Filmek"
series="/mnt/disks/downloads/Sorozatok"
pattern="\.srt$|\.sub$|\.ass$|\.ssa$|\.nfo$|\.txt$"

search_folder() {
    local folders="$( ls -A1 -d -a $1/*/ 2> /dev/null )"
    if [[ ! -z "$folders" ]]; then
        for dir in $folders; do
            local result=$( search_folder $dir )
            if [[ $result == "delete" ]]; then
                echo "REMOVE: $dir" >&2
                rm -rf "$dir" >&2
            fi
        done
    else
        local files=$( ls "$1" )
        local count=$( echo "$files" | sed '/^\s*$/d' | wc -l )
        if [ "$count" -eq "0" ]; then
            echo "delete"
        else
            for line in $files; do
                if [[ ! $line =~ $pattern ]]; then
                    echo "no"
                    break
                fi
            done
            echo "delete"
        fi
    fi
}

echo "Cleaning Movies"
search_folder "$movies"

echo "Cleaning Series"
search_folder "$series"

echo "Finished..."