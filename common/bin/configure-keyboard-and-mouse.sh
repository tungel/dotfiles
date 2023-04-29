#!/bin/bash

# adjust keyboard speed and reload keyboard mapping
xset r rate 200 30; xmodmap ~/.Xmodmap

# disable external mouse natural scrolling
device_id=$(xinput list --id-only 'Microsoft Microsoft® 2.4GHz Transceiver v9.0 Mouse')
if [[ -n "$device_id" ]]; then
  xinput set-prop $device_id 'libinput Natural Scrolling Enabled' 0
else
  echo "No known external mouse is connected."
fi

