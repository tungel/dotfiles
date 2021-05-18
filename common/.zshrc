# built-in module for profiling zsh. Run: `zprof`
zmodload zsh/zprof

# check how long it takes to launch zsh:
# for i in $(seq 1 10); do time zsh -i -c exit; done

# ref: https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92
autoload -Uz compinit promptinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

skip_global_compinit=1

# Lines configured by zsh-newuser-install, use vi mode (-v)
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

# For autocompletion with an arrow-key driven interface:
# Press tab twice to active the menu
zstyle ':completion:*' menu select

# use color in completion
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

# allow shift-tab for menu complete
bindkey '^[[Z' reverse-menu-complete

# Use ~/.zfunctions for autoloading functions
# this must be put above promptinit
fpath=( "$HOME/.zfunctions" $fpath )
promptinit
# prompt adam2ltt 8bit
# End of lines added by compinstall

# Prevent from putting duplicate lines in the history
setopt HIST_IGNORE_DUPS

# Persistent rehash to automatically find new files in /usr/bin of new installed
# packages
setopt nohashdirs

# disable flow control
# (default was: Ctrl+s (pause transmission), Ctrl+q (resume transmission))
setopt noflowcontrol

# Map Ctrl-S to sth usefull other than XOFF (interrupt data flow).
# search functionality (same as Ctrl+R) in bash
stty -ixon

# ==============================================================================
#---begin dirstack
# commented out 2015-04-14 because it interfere with Ranger's `S` command to go
# to shell
# ---
# usage: `dirs -v` and `cd -<NUM>`
# https://wiki.archlinux.org/index.php/Zsh
# DIRSTACKFILE="$HOME/.cache/zsh/dirs"
# if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
#   dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
#   [[ -d $dirstack[1] ]] && cd $dirstack[1]
# fi
# chpwd() {
#   print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
# }

# DIRSTACKSIZE=20

# setopt autopushd pushdsilent pushdtohome

# ## Remove duplicate entries
# setopt pushdignoredups

# ## This reverts the +/- operators.
# setopt pushdminus
#---end dirstack
# ==============================================================================


autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
alias help=run-help

# ==============================================================================
# https://wiki.archlinux.org/index.php/Zsh
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
# [[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
# [[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
# alter native method includes running `autoload zkbd` then run `zkbd`, ...
# ==============================================================================

# history search based on what already entered
# Need below 2 lines to make it work in tmux. Setting in the ablove zkbd
# compatible hash doesn't work in tmux...
# bindkey "^[[A" history-beginning-search-backward
# bindkey "^[[B" history-beginning-search-forward

# http://superuser.com/questions/187639/zsh-not-hitting-profile
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# PROMPT with git status
source ~/.zplugins/zsh-git-prompt/zshrc.sh
PS1=''
case ${TERM} in
  xterm*|linux*|rxvt*|tmux*|Eterm|aterm|kterm|gnome*)
    PS1=$'%{\e[1;34m%}%n %{\e[0m%}at %{\e[0;33m%}%M %{\e[0m%}in %{\e[1;32m%}%~ %b$(git_super_status)
%{\e[1;30m%}>>> %{\e[0m%}'
    ;;
  # for emacs
  "dumb")
    PROMPT_COMMAND=
    PS1="> "
esac



# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}


# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# ==============================================================================
# zsh change cursor color to indicate vi mode
# https://bbs.archlinux.org/viewtopic.php?pid=751788
# zle-keymap-select () {
#     if [ $TERM = "rxvt-256color" ]; then
#         if [ $KEYMAP = vicmd ]; then
#             echo -ne "\033]12;Red\007"
#         else
#             echo -ne "\033]12;Grey\007"
#         fi
#     fi
# }
# zle -N zle-keymap-select
# zle-line-init () {
#     zle -K viins
#     if [ $TERM = "rxvt-256color" ]; then
#         echo -ne "\033]12;Grey\007"
#     fi
# }
# zle -N zle-line-init
# -------------  the above version doesn't work in tmux ----------------------

# ---------- new version works in tmux ----------------------------------------
# http://ivyl.0xcafe.eu/2013/02/03/refining-zsh/#vi_mode_status_indicator
# urxvt (and family) accepts even #RRGGBB

# the cursor color is inversed from Vim's cursor color setting
INSERT_PROMPT="green"
COMMAND_PROMPT="gray"

# helper for setting color including all kinds of terminals
set_prompt_color() {
    if [[ $TERM = "linux" ]]; then
       # nothing
    # elif [[ $TMUX != '' && "${TERM}" == 'xterm-256color' ]]; then
    #     printf '\033Ptmux;\033\033]12;%b\007\033\\' "$1"
    else
        echo -ne "\033]12;$1\007"
    fi
}

# change cursor color basing on vi mode
zle-keymap-select () {
    if [ $KEYMAP = vicmd ]; then
        set_prompt_color $COMMAND_PROMPT
    else
        set_prompt_color $INSERT_PROMPT
    fi
}

zle-line-finish() {
    set_prompt_color $INSERT_PROMPT
}

zle-line-init () {
    zle -K viins
    set_prompt_color $INSERT_PROMPT
}

zle -N zle-keymap-select
zle -N zle-line-init
zle -N zle-line-finish
# ==============================================================================

# reduce time waiting for key escape sequence
# don't reduce to too small value, otherwise sudo.plugin.zsh won't work
export KEYTIMEOUT=15

# ==============================================================================
# Plugins...

# syntax plugin must be loaded before the history-substring-search
source ~/.zplugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zplugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zplugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source ~/.zplugins/z.sh

# may need to force rebuild zcompdump: `rm -f ~/.zcompdump; compinit`
fpath=(~/.zplugins/zsh-completions/src $fpath)

source ~/.zplugins/sudo.plugin.zsh
# source ~/.zplugins/archlinux.plugin.zsh
# commented it out as it seems interfere with RVM
# source ~/.zplugins/dirhistory.plugin.zsh
source ~/.zplugins/tmux.plugin.zsh
# ==============================================================================

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# use Ctrl+space to accept the current suggestion
bindkey '^ ' autosuggest-accept

# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
pathAdd $HOME/.rvm/bin


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

