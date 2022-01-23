#!/bin/bash

# Usage: rename-with-base.sh 2022-01-21-opnsense yes


# the command will rename all the files in the current dir using the provided
# base name and the generated sequence numbers, for example:
# 'screenshot- 2022-01-21 at 19.11.54.png' -> '2022-01-21-opnsense-001.png'
# 'screenshot- 2022-01-21 at 19.11.55.png' -> '2022-01-21-opnsense-002.png'

BASE_NAME=${1:-file}
CONFIRM=${2:-no}

a=1
for current_name in *.png; do
  new_name=$(printf "$BASE_NAME-%03d.png" "$a")
  echo "$current_name -> $new_name"
  if [ "$CONFIRM" == "yes" ]; then
    mv -i -- "$current_name" "$new_name"
  fi
  let a=a+1
done

