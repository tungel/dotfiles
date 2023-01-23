#!/bin/bash

mkdir processed
for i in *.MP4; do
  file_name_without_extension=$(echo `basename $i` | cut -f 1 -d '.')
  ffmpeg -i $i -vcodec libx265 -crf 24 processed/$file_name_without_extension-processed-ffmpeg.MP4
done

