#!/bin/bash
#https://bbs.archlinux.org/viewtopic.php?id=80145&p=9

# depend on:
# sudo pacman -S mlocate
# sudo pacman -S xsel
if [ -f $HOME/.dmenurc ]; then
    . $HOME/.dmenurc
else
    DMENU="dmenu -fn $DMENUFONT -i"
fi

input="$(xsel -o | $DMENU -p "file search:")"
[[ -z "$input" || $? -ne 0 ]] && exit 1

result="$(echo "$input" | locate -e -i -r "$input")"
while [[ -z "$result" ]]; do
    input="$($DMENU -p "[1] file search:" <&- )"
    [[ -z "$input" || $? -ne 0 ]] && exit 1
    result="$(echo "$input" | locate -e -i -r "$input")"
done
result="$(echo "$result" | sed -e 's,'"${HOME}"',~,g' | $DMENU -l 8 -p "search result:")"

if [[ "$result" && $? -eq 0 ]]; then
    result="$(echo "$result" | sed -e 's,^~/,'"${HOME}/"',g')"
    if [[ -f "$result" ]]; then
        xdg-open "$result"
    elif [[ -d "$result" ]]; then
        # use ranger to open directory
        terminology -e ranger "$result"
    fi
fi

