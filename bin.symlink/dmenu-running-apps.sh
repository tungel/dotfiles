#!/bin/bash

# Search through open programs and switch to their tag
application=$(
    # List all running programs
    # List client applications running on a display
    # https://www.archlinux.org/packages/extra/i686/xorg-xlsclients/
    xlsclients |\

    # Fix Virtualbox and LibreOffice
    sed -e 's/.*VirtualBox/foobar  virtualbox/g' -e 's/.*soffice/foobar  libreoffice/g' |\

    # Remove flash from results
    grep -v "plugin-container" |\

    # Show only app-names
    cut -d" " -f3 |\

    # Pipe to dmenu ($@ to include font settings from dwm/config.h)
    # dmenu -i -p "Switch to" $@
    # dmenu -fn "Roboto-10" -i -p "Switch to" $@
    dmenu -fn $DMENUFONT -i -p "Switch to" $@
)

# Switch to chosen application
case $application in
    # gimp | truecrypt)
    #     xdotool search --onlyvisible -classname "$application" windowactivate &> /dev/null
    #     ;;
    *)
        xdotool search ".*${application}.*" windowactivate &> /dev/null
        ;;
esac

#===============================================================================
# # simpler but working: (may not work with virtualbox, gimp and truecrypt
# # Search through open programs and switch to their tag

# # List all applications (and ignore "plugin-container", since it's flash in firefox)
# application=$(xlsclients | grep -v "plugin-container" | cut -d" " -f3 | dmenu -fn "Roboto-10" -i -p "Switch to")

# # Switch to application
# xdotool search "$application" windowactivate &> /dev/null
#===============================================================================




# Search through open programs and switch to their tag
# original source: https://github.com/orschiro/dmenu-scripts-collection/blob/master/dmenu_running_apps/dmenu_running_apps
# http://spiralofhope.com/wmctrl-examples.html

# application=$(
#     # List all running programs
#     wmctrl -l |\

#     # Titles only
#     cut -d' ' -f5- |\

#     # Pipe to dmenu ($@ to include font settings from dwm/config.h)
#     dmenu -b -i -p 'Switch to' -fn 'Roboto-10' -nf '#666666' -nb '#000000' -sf '#ffffff' -sb '#000000' $@
# )

# # remove special characters that mess up with xdotool search ([]~)
# application=$(echo $application | sed 's/\[/./' | sed 's/\]/./' | sed 's/\~/./')

# # Switch to chosen application
# case $application in
#     gimp | truecrypt)
#         xdotool search --onlyvisible -classname "$application" windowactivate &> /dev/null
#         ;;
#     *)
#         xdotool search ".*${application}.*" windowactivate &> /dev/null
#         ;;
# esac


