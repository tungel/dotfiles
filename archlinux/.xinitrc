#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

#set keyboard speed
#xset r rate 200 30

#synclient TouchpadOff=1

#xsetroot -cursor_name left_ptr
#setxkbmap -layout en

#source /etc/X11/xinit/xinitrc.d/30-dbus
# eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
#export GPG_AGENT_INFO SSH_AUTH_SOCK

# for personal fonts
xset fp+ ~/.fonts/gohufont
xset fp+ ~/.fonts
xset fp rehash


# Fix java application run a blank window GUI (including Matlab)
# sudo pacman -S wmname
# wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1

# don't need to run this anymore, ssh-agent is handled in ~/.profile
# eval `/usr/bin/ssh-agent -s`

if [ -f ~/.autostart ] ; then
    sh ~/.autostart &
fi

# check and enable various useful services if Arch is running inside VirtualBox
# also can use `dmesg` command to check this
if [ $(lspci | grep -i VirtualBox | wc -l) -gt 0 ]; then
  /usr/bin/VBoxClient-all
fi

killall xautolock

# locks in 10 minutes of inactivity, or whenever you place the mouse cursor in
# the bottom right corner for 3 seconds.
# xautolock -time 10 -locker slock -nowlocker slock -detectsleep -corners 000+ -cornerdelay 3 &
# the -corners option seems to cause random lock which is annoying
# xautolock -time 10 -locker slock -nowlocker slock -detectsleep &

# suspend after 10 mins of inactivity
xautolock -time 10 -locker ~/bin/xautolock-suspend &

~/.config/bspwm/monitor_changes.sh &
~/bin/configure-keyboard-and-mouse.sh

# http://linuxmafia.com/faq/Admin/release-files.html
# we can also use file /etc/os-release
if [ -f /etc/arch-release ] ; then
    # for Arch Linux
    sxhkd &
    exec bspwm
elif [ -f /etc/lsb-release ] ; then
    # for Linux Mint
    exec cinnamon-session
fi


#gnome-encfs-manager

# exec gnome-session
# exec startkde
# exec openbox-session
# exec startxfce4
# exec ck-launch-session xmonad
# ...or the Window Manager of your choice

