#!/usr/bin/env bash

# set 2 different wallpapers on 2 monitors

WALL_DIR=~/Dropbox/wallpapers/

if [[ -z "${MY_WALLPAPERS_DIR}" ]]; then
    files_list=$(find "$WALL_DIR" -type f)
else
    files_list=$({ find "$WALL_DIR" -type f; find "$MY_WALLPAPERS_DIR" -type f; })
fi

WALL1=$(echo "$files_list" | sort -R | tail -1)
WALL2=$(echo "$files_list" | sort -R | tail -1)

# WALL1=$(find "$WALL_DIR" -type f | sort -R | tail -1)
# WALL2=$(find "$WALL_DIR" -type f | sort -R | tail -1)

# feh --no-fehbg --bg-center "$WALL1" --bg-fill "$WALL2"
/usr/bin/feh --no-fehbg --bg-fill "$WALL1" --bg-fill "$WALL2"

