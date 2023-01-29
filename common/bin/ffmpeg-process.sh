#!/bin/bash

# https://video.stackexchange.com/questions/23741/how-to-prevent-ffmpeg-from-dropping-metadata

mkdir processed
for i in *.MP4; do
  file_name_without_extension=$(echo `basename $i` | cut -f 1 -d '.')
  ffmpeg -i $i -movflags use_metadata_tags -map_metadata 0 -vcodec libx265 -preset slow -crf 22 processed/$file_name_without_extension-processed-ffmpeg.MP4
done

