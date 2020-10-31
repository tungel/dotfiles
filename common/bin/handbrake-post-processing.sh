#!/bin/bash

# For some reason, some mp4 files processed by HandBrakeCLI are larger than the
# original ones. Below script checks whether this is the case and delete the
# larger processed files and keep the original one:

# ref: https://stackoverflow.com/questions/23331864/check-if-two-files-are-different-sizes-in-bash
# [[ $(uname) =~ 'Darwin'|'BSD' ]] && { optChar='f'; fmtString='%z'; }

function file_size() {
  local optChar='c' fmtString='%s'
  [[ $(uname) =~ 'Darwin' ]] && { optChar='f'; fmtString='%z'; }
  stat -$optChar "$fmtString" "$@"
}

mkdir -p ok-to-delete
for i in *.mp4; do
  file_name_without_extension=$(echo `basename $i` | cut -f 1 -d '.')

  processed_file_path="processed/$file_name_without_extension-processed-handbrake.mp4"

  if (( $(file_size $i) < $(file_size $processed_file_path) )); then
    echo "Processed file size is larger than the original one"
    echo $i : $processed_file_path
    echo "delete the handbrake processed file because it is larger"
    rm $processed_file_path
    echo "Moving original file $i to processed folder"
    mv $i processed/$i
  else
    # the processed file is smaller than the original one, this is good.
    # so, we move the original file to somewhere else to mark it as done
    mv $i ok-to-delete/
  fi
done

