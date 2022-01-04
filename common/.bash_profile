#
# https://github.com/everbot/dotfiles
#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

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
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
