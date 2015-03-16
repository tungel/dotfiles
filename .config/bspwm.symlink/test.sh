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

# Base Colors
BLACK="282A2E"
RED="A54242"
GREEN="8C9440"
YELLOW="DE935F"
BLUE="5F819D"
MAGENTA="85678F"
CYAN="5E8D87"
WHITE="707880"

# Get Battery Stats
# usage: get_bat $UNUSED $USED
# Battery status monitor settings
BATTERY_UNUSED="%{F#FF${RED}}♥"
BATTERY_USED="%{F#FF${WHITE}}♥"
get_bat () {
  unused=$1
  used=$2
  if [ -d /sys/class/power_supply/BAT1 ]; then
    percent=$(acpi | egrep -o [0-9]+%)
    percent=${percent:0:$(expr length $percent - 1)}
    echo $percent
  else
    percent="100"
  fi
  bat=$(($percent / 10))
  stars=${unused}
  x=1

  # echo $percent
  echo $bat

  while [ $x -lt $bat ]; do
    stars=${stars}${unused}
    x=$(($x + 1))
    # echo $x
  done

  while [ $x -lt 10 ]; do
    stars=${stars}${used}
    x=$(($x + 1))
    # echo $x
    echo $stars
  done

  printf "%s\n" ${stars}
}

echo "Volume:" $(panel_volume)

num_mon=$(bspc query -M | wc -l)
if [ $num_mon -gt 1 ] ; then
    echo "Tunggggggggg"
else
    echo "sqlllllllllll"
fi

BAT=$(get_bat $BATTERY_UNUSED $BATTERY_USED)
echo $BAT

DATE=$(date +"%d %H:%M:%S")
echo $DATE


#-------------------------------------------------------------------------------
# check cpu usage
# https://bbs.archlinux.org/viewtopic.php?id=75937
PREV_TOTAL=0
PREV_IDLE=0

# while true; do
#   CPU=(`cat /proc/stat | grep '^cpu '`) # Get the total CPU statistics.
#   unset CPU[0]                          # Discard the "cpu" prefix.
#   IDLE=${CPU[4]}                        # Get the idle CPU time.

#   # Calculate the total CPU time.
#   TOTAL=0
#   for VALUE in "${CPU[@]}"; do
#     let "TOTAL=$TOTAL+$VALUE"
#   done

#   # Calculate the CPU usage since we last checked.
#   let "DIFF_IDLE=$IDLE-$PREV_IDLE"
#   let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
#   let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"
#   echo -en "[ Cpu :: $DIFF_USAGE% ]"

#   # Remember the total and idle CPU times for the next check.
#   PREV_TOTAL="$TOTAL"
#   PREV_IDLE="$IDLE"

#   # Wait before checking again.
#   sleep 1
# done


echo -e "                                        \e[34m+\e[0m"
echo -e "                                        \e[34m#\e[0m"
echo -e "                                       \e[34m###\e[0m"
echo -e "                                      \e[34m#####\e[0m"
echo -e "                                      \e[34m######\e[0m"
echo -e "                                     \e[34m; #####;\e[0m"
echo -e "                                    \e[34m+##.#####\e[0m"
echo -e "                                   \e[34m+##########\e[0m"
echo -e "                                  \e[34m#############;\e[0m"
echo -e "                                 \e[34m###############+\e[0m"
echo -e "                                \e[34m#######   #######\e[0m"
echo -e "                              \e[34m.######;     ;###;''.\e[0m"
echo -e "                             \e[34m.#######;     ;#####.\e[0m"
echo -e "                             \e[34m#########.   .########'\e[0m"
echo -e "                            \e[34m######'           '######\e[0m"
echo -e "                           \e[34m;####                 ####;\e[0m"
echo -e "                           \e[34m##'                     '##\e[0m"
echo -e "                          \e[34m#'                         '#\e[0m"

