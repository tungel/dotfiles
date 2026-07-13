#!/bin/bash

# adjust keyboard speed and reload keyboard mapping
xset r rate 200 30; xmodmap ~/.Xmodmap

# # disable external mouse natural scrolling
# device_id=$(xinput list --id-only 'Microsoft Microsoft® 2.4GHz Transceiver v9.0 Mouse')
# if [[ -n "$device_id" ]]; then
#   xinput set-prop $device_id 'libinput Natural Scrolling Enabled' 0
# else
#   echo "No known external mouse is connected."
# fi

# Define the list of mouse device names
devices=(
    "Microsoft Microsoft® 2.4GHz Transceiver v9.0 Mouse"
    "pointer:Razer Razer DeathAdder Essential"
)

# Loop through each device and configure it
for device in "${devices[@]}"; do
    device_id=$(xinput list --id-only "$device" 2>/dev/null)
    
    if [[ -n "$device_id" ]]; then
        xinput set-prop "$device_id" 'libinput Natural Scrolling Enabled' 0
        echo "Disabled natural scrolling for: $device (ID: $device_id)"
    fi
done

