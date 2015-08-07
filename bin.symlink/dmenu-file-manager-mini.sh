#!/bin/bash

file=1
while [ "$file" ]; do
    file=$(ls -1 --group-directories-first | dmenu -fn $DMENUFONT -l 10 -p "FileMan: $(basename $(pwd))")
    if [ -e "$file" ]; then
        owd=$(pwd)
        if [ -d "$file" ]; then
            cd "$file"
        else [ -f "$file" ]
            if which xdg-open &> /dev/null; then
                exec xdg-open "$owd/$file" &
                unset file
            fi
        fi
    fi
done
