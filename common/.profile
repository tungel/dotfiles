
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export TLPC=~/.tlpc

MOREALIASES=~/dev/dotfiles-private/morealiases.sh
# some more aliases for personal usage
if [ -e $MOREALIASES ]; then
    source $MOREALIASES
fi

# machine specific aliases
CUSTOM_ALIASES=~/morealiases.sh
if [ -e $CUSTOM_ALIASES ]; then
    source $CUSTOM_ALIASES
fi

if [ -e /etc/profile ]; then
    source /etc/profile
fi

pathAdd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
# -A: show all, including dotfiles, except . and ..
# -v: natural sort of number
# -1 (one): list (use -l for long version)
# -h: human-readable sizes
alias ll='ls -lAv1h --color=always --time-style=long-iso --group-directories-first'
alias la='ls -A'
alias l='ls -CF'

# -I: prompt once before removing more than three files or recursively
# -v: verbose
alias rm='command rm -Iv'

# List files only
# alias lsf="ls -lp | ag -v /" # (or grep -v '^d')
alias lsf="ls -alh | ag -v '^d'" # (or grep -v '^d')

# List directories only
alias lsd="ls -alh | ag '^d'" # (or grep -v '^d')

# for WiFi
alias wifiup='sudo ip link set wlo1 up'
#alias wifiup='sudo ip link set wlp0s29f7u1 up'
alias wificonnect='sudo wpa_supplicant -i wlo1 -c /etc/wpa_supplicant.conf -B'
#alias wificonnect='sudo wpa_supplicant -i wlp0s29f7u1 -c /etc/wpa_supplicant.conf -B'
alias wifiwep='sudo iwconfig wlo1 essid "wifi-id" key s:password'
alias wifiip='sudo dhcpcd wlo1'
#alias wifiip='sudo dhcpcd wlp0s29f7u1'

# for LAN network
alias lanup='sudo ip link set enp3s0 up'
alias lanip='sudo dhcpcd enp3s0'
#alias phoneup='sudo ip link set enp0s29f7u4u4u1 up'
#alias phoneip='sudo dhcpcd enp0s29f7u4u4u1'

# for Android USB tethering: connect to the usb port beside the HDMI
alias phoneip='sudo dhcpcd enp0s29f7u2'

#fix the DNS problem of the new router
alias jurong='echo "nameserver 165.21.100.88" | sudo tee /etc/resolv.conf'


# adjust keyboard speed and configure mouse natural scrolling
alias mykb='configure-keyboard-and-mouse.sh'

# disable synaptics mouse/touch pad mouse
alias paddis='synclient TouchpadOff=1'
# enable synaptics mouse/touch pad mouse
alias paden='synclient TouchpadOff=0'

#for bluetooth
alias onbt='sudo systemctl start bluetooth.service'

#for mpd music
alias music="bash ~/startmusic.sh &"

alias topbigdirs="du -h | sort -rh | head -n 20"
alias topbigfiles="find . -type f -exec du -Sh {} + | sort -rh | head -n 20"

alias ag="ag -i --hidden"
alias agr="ag -i --hidden -G '.*.rb'" # search only ruby files
# ag -G ".*.(rb|haml)" # search *.rb and *.haml files

alias rg="rg -i --hidden"

# ref: https://exiftool.org/exiftool_pod.html#RENAMING-EXAMPLES
# %%f: the original file name
# %%c: adding a copy number with leading '-' if the file already exists (%-c),
# and preserving the original file extension (%e). Note the extra '%' necessary
# to escape the filename codes (%c and %e) in the date format string.
alias exif-rename-by-createdate-jpg="exiftool '-FileName<CreateDate' -d %Y%m%d_%H%M%S-%%f%%-c.%%e -ext jpg ."
# alias exif-rename-by-createdate-mp4="exiftool '-FileName<LastUpdate' -d %Y%m%d_%H%M%S-%%f%%-c.%%e -ext mp4 ."

#for matlab
# export MATLAB_JAVA=/usr/local/MATLAB/R2014a/sys/java/jre/glnxa64/jre
export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre
# Matlab can also be run with:
# MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre matlab -desktop
# to test which java version is used, in Matlab, type: version -java
# alias matlab="/usr/local/MATLAB/R2011b/bin/matlab -nodesktop -nosplash"
# Allow Matlab2011b run with -nodesktop but with splash so that it will not hang
# when plotting
# alias matlab="/usr/local/MATLAB/R2011b/bin/matlab -nodesktop"
alias matlab="/usr/local/MATLAB/R2014a/bin/matlab -nodesktop -nosplash"

#for git:
alias gitp="git pull"
alias gits="git status -sb"
alias gitc="git commit -am"
alias gitco="git checkout "
alias gitcom="git checkout master"
# git pull and rebase
alias gitprb="git stash && git pull && git rebase && git stash apply && git stash drop"

# drop all stashes
alias gitstashclean="while git std; do :; done"

alias dotfiles="cd ~/dev/mylinux/dotfiles/"

# for mount/unmount USB flashdrive using devmon
alias um="devmon --mount"
alias uu="devmon --unmount"

alias findproc="ps aux | grep "
alias fp="ps aux | grep "
alias killproc="kill -9"
alias kp="kill -9"

# Find out which distro we are using
alias mydistro="cat /etc/*-release"

# for gvim to load back the session
# alias gvim="gvim -S ~/session.gvim"

# make Acer laptop brighter:
alias brighter="sudo tee /sys/class/backlight/intel_backlight/brightness <<< 1200"

# sudo make install/uninstall
alias smi="sudo make install"
alias smu="sudo make uninstall"

# sublime
alias sublime="LANG=en_US.UTF-8 ~/Dropbox/shared/sublime3/sublime_text_Linux_64"

# output to 4k monitor (display port) on the left and to a HD monitor (HDMI port) on the right
alias mymonitors="xrandr --output DP-0 --auto --primary --pos 0x0 --panning 3840x2160+0+0 --output HDMI-0 --auto --right-of DP-0 --panning 1920x1080+3840+0"

# kill and restart pulseaudio before setting audio output
alias myaudio-hdmi="pulseaudio -k; pulseaudio --start; pacmd set-card-profile 0 output:hdmi-stereo"
alias myaudio-internal="pulseaudio -k; pulseaudio --start; pacmd set-card-profile 1 output:analog-stereo+input:analog-stereo"

# project to external VGA monitor
alias vga="xrandr --output VGA1 --mode 1920x1080"
alias vga2="xrandr --output VGA2 --mode 1920x1080"

# To enable various useful stuff for Arch Linux guest in VirtualBox machine
alias myvirtualbox="sudo modprobe -a vboxguest vboxsf vboxvideo ; \
                    sudo VBoxClient-all & ; \
                    sudo systemctl start vboxservice.service"

alias foxit="wine 'C:\\windows\\command\\start.exe' /Unix ~/.wine/dosdevices/c:/users/Public/Desktop/FoxitReader.lnk &"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#for NXJBROWSER
alias nxjexplore='~/Downloads/lego/leJOS_NXJ_0.9.1beta-3/bin/nxjbrowse'
alias cdlejos='cd ~/Downloads/lego/leJOS_NXJ_0.9.1beta-3'

alias mybspwm="~/.config/bspwm/bspwmrc"
alias mybspwm2="~/.config/bspwm/bspwmrc2"

# Sync time and store to hardware clock
alias mytime="sudo ntpd -qg && sudo hwclock -w"

# for zathura and vim for latex
# zathura -s -x 'gvim --servername SYNCTEX --remote +%{line} %{input}' thesis.pdf
alias zavim="zathura -s -x 'gvim --servername SYNCTEX --remote +%{line} %{input}'"

alias dev="cd ~/Dropbox/dev"

# for Dropbox and other app that need to monitor files
alias mynotify='sudo sysctl fs.inotify.max_user_watches=1000000000'

# list all users
alias userlist='cut -d: -f1 /etc/passwd'

# list all groups
alias grouplist='cut -d: -f1 /etc/group'

# AUR Arch Linux has moved to https://aur4.archlinux.org but by default yaourt
# doesn't seem to use the new url, so here is the fix:
alias yaourt4='yaourt --aur-url https://aur4.archlinux.org'

# for Jekyll
alias jekyllstart="cd ~/Dropbox/dev/everbot.github.io && bundle exec jekyll serve"

# list all docker containers
alias da='docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"'
# list running containers
alias dr='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"'
# list docker images
alias di='docker images'

# export all changed files to an archive
# to include newly added files, run `git add *` before running this alias
# ref: https://stackoverflow.com/questions/2997612/how-to-export-all-changed-added-files-from-git
#      https://stackoverflow.com/questions/1371261/get-current-directory-name-without-full-path-in-a-bash-script
# this will create a file like `2021-11-12-<current_dir_name>-git-backup.tar.gz`
alias gitbackup='git diff --diff-filter=ACMRT --name-only HEAD | xargs tar -czf `date +%F`-${PWD##*/}-git-backup.tar.gz'

# remove xcode DerivedData
alias xcodecleanup='if [[ -e ~/Library/Developer/Xcode/DerivedData ]]; then rm -rf ~/Library/Developer/Xcode/DerivedData/*; fi'

# download and save youtube video as m4a audio file
alias youtube_dl_audio="youtube-dl -f 'bestaudio[ext=m4a]'"

# Usage: `youtube_play 'faded'` will play Alan Walker's Faded song. The downloaded audio
# file is saved in `${TMPDIR}`.
youtube_play() {
    youtube-dl --default-search=ytsearch: \
               --youtube-skip-dash-manifest \
               --output="${TMPDIR:-/tmp/}%(title)-s%(id)s.%(ext)s" \
               --restrict-filenames \
               --format="bestaudio[ext!=webm]" \
               --exec=mpv "$*"
}

alias myconvertalltiffs2pdf='for tiff in *.tif; do tiff2pdf -o "`basename "${tiff}" .tif`.pdf" "${tiff}"; done'
alias myresizepdf='for pdf in *.pdf; do pdf2ps "${pdf}" temp.ps; ps2pdf temp.ps `basename "${pdf}" .pdf`-resized.pdf; rm temp.ps; done'

alias startredshift='systemctl --user start redshift.service'
alias stopredshift='systemctl --user stop redshift.service'

alias simplehttpserver="ruby -rwebrick -e'WEBrick::HTTPServer.new(Port: 8000, DocumentRoot: Dir.pwd).start'"
# for Ruby gem
# export PATH=$PATH:~/.gem/ruby/2.2.0/bin/
# GEM_ROOT, GEM_PATH
# export GEM_HOME=~/.gem/ruby/2.2.0
# PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
pathAdd ~/.gem/ruby/2.3.0/bin

# fix problem with vim colorscheme in tmux
# http://stackoverflow.com/questions/10158508/lose-vim-colorscheme-in-tmux-mode
# alias tmux="TERM=screen-256color-bce tmux" <- not very nice
alias tmux="tmux -2" # force tmux to use 256 colors

# for vim-fireplace console
# also fix problem with color in tmux plugin from oh-my-zsh
# Update 2015-04-17: we don't really need to manually set TERM variable. In
# fact, manually setting it may introduce trouble due to wrong terminal name.
# export TERM=rxvt-256color

# change system-wide editor
#export VISUAL="/usr/bin/vim -p -X"
export VISUAL="$(which lvim)"
export EDITOR="$(which lvim)"

# setup ~/.config/nvim for Neovim
setup_nvim_config() {
  # For neovim
  local home_config=$HOME/.config
  local nvim_config="${home_config}/nvim"
  mkdir -p ${home_config}

  if [[ -e "${nvim_config}" ]]; then
    rm -rf "${nvim_config}"
    rm -f "${nvim_config}"
  fi

  if [[ -e "$HOME/.vim" ]]; then
    ln -s "$HOME/.vim" "${nvim_config}"
  fi

  if [[ -e "$HOME/.vimrc" ]]; then
    rm -rf "${nvim_config}/init.vim"
    ln -s "$HOME/.vimrc" "${nvim_config}/init.vim"
  fi
}

# - Non-root user: set umask to `077` to increase security, so that the default
#   permission:
#   + new file is 600
#   + new directory is 700
# - Root: umask to `022`, so that default permission:
#   + new file is 644
#   + new directory is 755
# if [ "$EUID" -ne 0 ]; then
# if (( $EUID != 0 )); then
#     # non-root user
#     umask 077
# else
#     # root
#     umask 022
# fi

# Use `umask 022` for sudo command to allow root user to create new file with 755
# permission, which allows reading and executing permissions to all users
# sudo() {
#     old=$(umask)
#     umask 0022
#     command sudo "$@"
#     umask $old
# }

# print the wireless driver in use
mywifidriver() {
    wireless=$(lspci | grep -i wireless | awk '{ print $1  }')
    if [ $wireless ]; then
        lspci -vv -s $wireless | grep -iP 'kernel driver in use' | awk -F: '{ gsub(/[ \t]+/, ""); print $2;  }'
    fi
}

# restart wifi driver as it's broken sometimes after waking up from suspend
mywifirestart() {
    wirelessDriver=$(mywifidriver)
    if [ $wirelessDriver ]; then
        echo "Restarting wireless driver: $wirelessDriver"
        sudo modprobe -r $wirelessDriver
        sudo modprobe $wirelessDriver
    fi
}

# Search a pattern from content of all PDF files in current directory recursively
# Example usage: searchpdf '1\.\d+'
searchpdf() {
    find . -iname '*.pdf' -exec pdfgrep -iPn "$1" {} +
}

# for dmenu font
export DMENUFONT="Consolas-11"

# For Java
# export JAVA_HOME=/usr/lib/jvm/java-7-openjdk
# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk/jre # jre only
# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
# use Oracle Java
# export JAVA_HOME=/usr/lib/jvm/java-8-jdk
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home
# export JAVA_HOME=/usr/lib/jvm/java-7-oracle

if [[ $OSTYPE == 'darwin'* ]]; then
  # macOS?
  # export JAVA_HOME=$(/usr/libexec/java_home)
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
fi

# IntelliJ IDEA, link `current` directory to latest stable release dir
alias idea="~/dev/tools/idea/current/bin/idea.sh"

# Fix Maven Java heap space error
export MAVEN_OPTS="-Xmx1024m"

# configuration for Hadoop where it is downloaded to ~/mytemp/hadoop/
HADOOP_PREFIX=~/dev/libs/hadoop
# PATH=$PATH:${HADOOP_PREFIX}/bin:${HADOOP_PREFIX}/sbin
pathAdd ${HADOOP_PREFIX}/bin
pathAdd ${HADOOP_PREFIX}/sbin

alias mypsql="sudo su postgres -c psql"
alias avroview="java -jar ~/dev/libs/avro-tools-1.7.7.jar tojson "

# for flume
# PATH=~/dev/libs/flume/bin:$PATH
pathAdd ~/dev/libs/flume/bin

# for sqoop
export SQOOP_HOME=~/dev/libs/sqoop
export SQOOP_CONF_DIR=~/dev/libs/sqoop/conf
export HADOOP_MAPRED_HOME=~/dev/libs/hadoop
pathAdd $SQOOP_HOME/bin

# for Go
export GOPATH=~/go
pathAdd $GOPATH/bin

# for local scripts/programs
# PATH=$PATH:~/bin
pathAdd ~/bin
pathAdd ~/local-bin
pathAdd ~/.local/bin

# PATH=$PATH:~/dev/libs/flume-client/flume-client-1.0-SNAPSHOT/bin
pathAdd ~/dev/libs/flume-client/flume-client-1.0-SNAPSHOT/bin
alias mydfs="hdfs dfs "

# update: [2015-12-27 17:33] [ALPM-SCRIPTLET] The SSH_ASKPASS environment
# variable is not exported by default anymore. Set it in /etc/profile to revert
# to the previous behavior
export SSH_ASKPASS="/usr/bin/ksshaskpass"

# handle ssh-agent
# ref: https://wiki.archlinux.org/index.php?title=SSH_keys&redirect=no#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(< ~/.ssh-agent-thing)"
fi

# temp ssh
alias ssht='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

# Usage: git-add-subtree https://github.com/path/to-repo.git
git_add_subtree() {
  local url_without_git=$(echo $1 | sed "s/\.git$//")
  local repo_name=$(basename $url_without_git)
  git subtree add --prefix "$repo_name" $1 master --squash
}

# 1-liner python server
python_server() {
  local port=${1:-8000}
  python -m http.server $port
}

# For Rust Cargo
pathAdd $HOME/.cargo/bin
# For Rust Racer completion
# export RUST_SRC_PATH=$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
export RUST_SRC_PATH=$HOME/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Add RVM to PATH for scripting
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
pathAdd $HOME/.rvm/bin

# aaap {{{
# jboss
export JBOSS_HOME=~/dev/libs/jboss
export M2_HOME=~/dev/aaap/aaap/apache-maven-phoenix
export M2=$M2_HOME/bin
pathAdd $M2
# }}}

# for ibus - input method framework to enter foreign characters
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# for python3 vscode on macOS
pathAdd $HOME/Library/Python/3.7/bin

# added by Miniconda3 4.5.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/ttl/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/ttl/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ttl/miniconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/ttl/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

pathAdd $HOME/.node_modules/bin

pathAdd $HOME/.rvm/bin
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

pathAdd $HOME/.local/bin

# for cloud dev desktop
pathAdd $HOME/.toolbox/bin

pathAdd $HOME/local-bin/apache-maven-3.6.3/bin
