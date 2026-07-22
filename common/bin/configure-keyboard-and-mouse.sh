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
    "ttl-mouse-02"
)

# Loop through each device and configure it
for device in "${devices[@]}"; do
    device_id=$(xinput list --id-only "$device" 2>/dev/null)
    
    if [[ -n "$device_id" ]]; then
        xinput set-prop "$device_id" 'libinput Natural Scrolling Enabled' 0
        echo "Disabled natural scrolling for: $device (ID: $device_id)"
    fi
done

# Reload hid_magicmouse with custom scroll settings if ttl-mouse-02 is connected
if xinput list --id-only 'ttl-mouse-02' &>/dev/null; then
    echo "ttl-mouse-02 detected, reloading hid_magicmouse with custom scroll settings..."
    sudo modprobe -r hid_magicmouse
    # scroll_speed can be set anywhere from 0 to 63. The default value is usually 32
    sudo modprobe hid_magicmouse scroll_acceleration=1 scroll_speed=50
fi

# Configure Apple keyboard (hid_apple)
if [ -f /sys/module/hid_apple/parameters/swap_fn_leftctrl ]; then
    echo 1 | sudo tee /sys/module/hid_apple/parameters/swap_fn_leftctrl &>/dev/null
    echo 1 | sudo tee /sys/module/hid_apple/parameters/swap_opt_cmd &>/dev/null
    echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode &>/dev/null
    echo "hid_apple key swap + fnmode applied"
fi

