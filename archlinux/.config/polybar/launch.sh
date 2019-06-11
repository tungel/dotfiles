#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

POLYBAR_CONFIG=~/.config/polybar/config

export MONITOR=$(polybar -m|tail -1|sed -e 's/:.*$//g')

# low DPI constants for .Xresources
XRESOURCES_DPI=92
XRESOURCES_FONT_SIZE=14

# low DPI constants for polybar
BAR_FONT_SIZE=11
export BAR_HEIGHT=20

if [[ "$1" == "hidpi" ]]; then
  BAR_HEIGHT=40
  BAR_FONT_SIZE=24

  XRESOURCES_DPI=187
  XRESOURCES_FONT_SIZE=26
fi

XRESOURCES=~/.Xresources
if [[ -w "${XRESOURCES}" ]]; then
  # search and replace DPI in line `Xft.dpi: 100`
  sed --in-place --follow-symlinks "/^Xft.dpi: [0-9]\+$/ s/: [0-9]\+$/: ${XRESOURCES_DPI}/" "${XRESOURCES}"
  # search and replace font size in line `URxvt.font:xft:Hack:pixelsize=14:antialias=true:hinting=true`
  sed --in-place --follow-symlinks "/^URxvt.*:xft:.*pixelsize=[0-9]\+:.*/ s/pixelsize=[0-9]\+/pixelsize=${XRESOURCES_FONT_SIZE}/" "${XRESOURCES}"

  xrdb -merge "${XRESOURCES}"
fi

if [[ -w "${POLYBAR_CONFIG}" ]]; then
  sed --in-place --follow-symlinks "/^font-[0-9]\+ = / s/size=[0-9]\+$/size=${BAR_FONT_SIZE}/" "${POLYBAR_CONFIG}"
else
  echo "Error: Unable to write to polybar config file"
  exit 1
fi

polybar top &

