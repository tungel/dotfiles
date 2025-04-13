#!/bin/bash

# A script that loops and watches for monitor changes

move_unplugged_external_desktops_to_internal() {
    # local INTERNAL="eDP1"
    local INTERNAL=$(xrandr --listmonitors | awk '/eDP/ {print $NF}')
    local EXTERNALS
    EXTERNALS=$(bspc query -M --names | grep -v "$INTERNAL")
    echo "External monitors: $EXTERNALS"

    for ext in $EXTERNALS; do
        if ! xrandr | grep -q "$ext connected"; then
            echo "Monitor $ext disconnected. Moving desktops to internal..."

            # note: have to add the % char before the monitor name to workaround
            # this issue https://github.com/baskerville/bspwm/issues/969
            # since the external monitor name is something like DP-4.1 (has a dot)
            for desk in $(bspc query -D -m %"$ext"); do
                bspc desktop "$desk" --to-monitor "$INTERNAL"
            done
        fi
    done
}

LAST_OUTPUT=""

while true; do
    CURRENT_OUTPUT=$(xrandr | grep " connected" | grep -v "eDP" | awk '{print $1}')

    if [[ "$CURRENT_OUTPUT" != "$LAST_OUTPUT" ]]; then
        echo "Monitor change detected: $CURRENT_OUTPUT"

        move_unplugged_external_desktops_to_internal >> /tmp/debug-monitor.txt
        ~/.config/bspwm/bspwmrc
        LAST_OUTPUT="$CURRENT_OUTPUT"
    fi

    sleep 5
done

