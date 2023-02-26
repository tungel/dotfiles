#!/bin/bash

# https://video.stackexchange.com/questions/23741/how-to-prevent-ffmpeg-from-dropping-metadata

mkdir processed

# process file mp4, MP4, ...
for i in *.[mM][pP]4; do
  file_name_without_extension=$(echo `basename $i` | cut -f 1 -d '.')
  # `-preset slow` is really slow
  # ffmpeg -i $i -movflags use_metadata_tags -map_metadata 0 -vcodec libx265 -preset slow -crf 22 processed/$file_name_without_extension-ffmpeg.MP4
  ffmpeg -i $i -movflags use_metadata_tags -map_metadata 0 -vcodec libx265 -crf 22 processed/$file_name_without_extension-ffmpeg.MP4
done

