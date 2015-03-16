#! /bin/sh

# https://github.com/everbot/dotfiles


# test bar with:
#A=lcr; for f in {0..9}; do for b in {0..9}; do for u in {0..9}; do ((f == b || f == u || b == u)) && continue; echo "%{${A:f%3:1}} $f / $b / $u"; sleep 0.1; done; done; done | bar -b -f '-microsoft-consolas-medium-r-normal-*-13-*-*-*-*-*-microsoft-*'

useDzen2=true

# https://wiki.archlinux.org/index.php/Bspwm
panel_volume()
{
        volStatus=$(amixer get Master | tail -n 1 | cut -d '[' -f 4 | sed 's/].*//g')
        volLevel=$(amixer get Master | tail -n 1 | cut -d '[' -f 2 | sed 's/%.*//g')
        # is alsa muted or not muted?
        if [ "$volStatus" == "on" ]
        then
                echo "%{Fyellowgreen} $volLevel %{F-}"
        else
                # If it is muted, make the font red
                echo "%{Findianred} $volLevel %{F-}"
        fi
}


cpu() {
    PREV_TOTAL=0
    PREV_IDLE=0

    while true; do
        CPU=(`cat /proc/stat | grep '^cpu '`) # Get the total CPU statistics.
        unset CPU[0]                          # Discard the "cpu" prefix.
        IDLE=${CPU[4]}                        # Get the idle CPU time.

        # Calculate the total CPU time.
        TOTAL=0
        for VALUE in "${CPU[@]}"; do
            let "TOTAL=$TOTAL+$VALUE"
        done

        # Calculate the CPU usage since we last checked.
        let "DIFF_IDLE=$IDLE-$PREV_IDLE"
        let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
        let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"
        echo -en "B |CPU:$DIFF_USAGE%" > "$PANEL_FIFO" &

        # Remember the total and idle CPU times for the next check.
        PREV_TOTAL="$TOTAL"
        PREV_IDLE="$IDLE"

        # wait before checking again
        sleep 1
    done &
}

#*******************************************************************************
# https://wiki.archlinux.org/index.php/Bspwm
# print battery info
battery() {
    # another method:
    # if [ -d /sys/class/power_supply/BAT1 ]; then
    #     percent=$(acpi | egrep -o [0-9]+%)
    #     percent=${percent:0:$(expr length $percent - 1)}
    #     echo $percent
    # else
    #     percent="100"
    # fi


    # BATPERC=$(acpi --battery | awk -F, '{print $2}')

    if [ -d /sys/class/power_supply/BAT1 ]; then
        BATPERC=$(acpi | egrep -o [0-9]+%)
        BATPERC=${BATPERC:0:$(expr length $BATPERC - 1)}

        if [ $useDzen2 == true ]; then
            echo $BATPERC%
        else
            # echo "%{Findianred} $BATPERC %{F-}"
            x="%{Findianred} $BATPERC% %{F-}"
            echo $x
        fi
    fi

    #or:
    # printf "%s" $x\%\%
}

# 2 variables for CPU usage
PREV_TOTAL=0
PREV_IDLE=0
while true; do
    DATE=$(date +"%a %d-%b %H:%M:%S")

    echo "D" "$DATE" > "$PANEL_FIFO" &


    CPU=(`cat /proc/stat | grep '^cpu '`) # Get the total CPU statistics.
    unset CPU[0]                          # Discard the "cpu" prefix.
    IDLE=${CPU[4]}                        # Get the idle CPU time.

    # Calculate the total CPU time.
    TOTAL=0
    for VALUE in "${CPU[@]}"; do
        let "TOTAL=$TOTAL+$VALUE"
    done

    # Calculate the CPU usage since we last checked.
    let "DIFF_IDLE=$IDLE-$PREV_IDLE"
    let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
    let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"
    DIFF_USAGE1=(`printf "%02d" $DIFF_USAGE`)

    # MEMUSED=(`free | awk '/buffers\/cache/{print $3/($3+$4) * 100.0;}'`)
    # +0.5 is to round it up
    # MEMUSED=(`free | awk '/buffers\/cache/{printf("%02d", $3/($3+$4) * 100.0 + 0.5);}'`)

    # update 2014-12-16 for new output of 'free' command:
    # free
    #               total        used        free      shared  buff/cache   available
    # Mem:        3932020      989560      226120      136252     2716340     2528136
    # Swap:             0           0           0
    #
    # So percent of really occupied memory = (used / total) because the new
    # output of 'used' from free command doesn't seem to include buff/cache like
    # previously
    MEMUSED=(`free | awk '/Mem/{printf("%02d", $3/($2) * 100.0 + 0.5);}'`)


    if [ $useDzen2 == true ]; then
        # echo "B" "CPU:$DIFF_USAGE1% MEM:$MEMUSED% ($(battery)" > "$PANEL_FIFO" &
        echo "S" "CPU:$DIFF_USAGE1% MEM:$MEMUSED%" > "$PANEL_FIFO" &
        echo "B" "$(battery)" > "$PANEL_FIFO" &
    else
        echo "B" "CPU:$DIFF_USAGE1%% MEM:$MEMUSED%% $(battery)" > "$PANEL_FIFO" &
    fi

    # Remember the total and idle CPU times for the next check.
    PREV_TOTAL="$TOTAL"
    PREV_IDLE="$IDLE"


    sleep 1s
done &
#*******************************************************************************


# these 2 lines are commented out on 2014-09-24
trap 'trap - TERM; kill 0' INT TERM QUIT EXIT
[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"

rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

bspc config top_padding $PANEL_HEIGHT
bspc control --subscribe > "$PANEL_FIFO" &
xtitle -sf 'T%s' > "$PANEL_FIFO" &

# call clock at interval 1seconds (-i 1)
# clock -sf 'S%a %H:%M:%S' -i 1 > "$PANEL_FIFO" &

# volume
# echo "V" "$(panel_volume)" > "$PANEL_FIFO" &



if [ $useDzen2 == true ]; then
    . ~/.config/bspwm/panel_colors_dzen2
else
    . ~/.config/bspwm/panel_colors
fi


if [ $useDzen2 == true ]; then
    # -ta l  : make the bar position on left edge
    # -e 'button3=' is to disable right click to exit dzen by default
    cat "$PANEL_FIFO" | ~/.config/bspwm/panel_bar | dzen2 -fn "$PANEL_FONT_FAMILY" -p -ta l -bg "$COLOR_BACKGROUND" -e 'button3='
else
    cat "$PANEL_FIFO" | ~/.config/bspwm/panel_bar-baraint | bar -g x$PANEL_HEIGHT -f "$PANEL_FONT_FAMILY" -F "$COLOR_FOREGROUND" -B "$COLOR_BACKGROUND"
fi

# cat "$PANEL_FIFO" | dzen2 -fn "$PANEL_FONT_FAMILY" &
# printf "%s\n" "Tung" | dzen2 -fn "$PANEL_FONT_FAMILY" -p &
# echo "Tung" | dzen2 -fn "$PANEL_FONT_FAMILY" -p &

wait

