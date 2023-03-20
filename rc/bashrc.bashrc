# Only source bashrc on interactive prompts
[[ $- != *i* ]] && return


# History management
####################
shopt -s histappend

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=10000
export HISTFILESIZE=10000
export PYTHONSTARTUP="$HOME/.config/pythonstartup.py"
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'


# Set prompt
############
precmd() {
  if [ -n "$TMUX" ]; then
    tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD"
  fi
}
compile_prompt() {
  local CONNECTBAR_DOWN=$'\u250C\u2500\u257C'
  local CONNECTBAR_UP=$'\u2514\u2500\u257C'
  local SPLITBAR=$'\u257E\u2500\u257C'
  local c_gray='\[\e[01;30m\]'
  local c_blue='\[\e[0;34m\]'
  local c_purple='\[\e[0;35m\]'
  local c_reset='\[\e[0m\]'

  # > Connectbar Down
  # Format:   (connectbar down)
  PS1="${c_gray}$CONNECTBAR_DOWN"

  # > Username
  # Format:   (bracket open)(username)(bracket close)
  PS1+="[${c_blue}\u${c_gray}]"

  # > Python Virtual Environment
  # Format:   (bracket open)(virtualenv)(bracket close)
  if [[ -n "$VIRTUAL_ENV" ]]; then
    PS1+="[${c_purple}${VIRTUAL_ENV##*/}${c_gray}]"
  elif [[ -n "$CONDA_DEFAULT_ENV" ]] && [[ "$CONDA_DEFAULT_ENV" != "base" ]]; then
    PS1+="[${c_purple}${CONDA_DEFAULT_ENV##*/}${c_gray}]"
  fi

  # > Working Directory
  # Format:   (splitbar)(bracket open)(working directory)(bracket close)(newline)(connectbar up)
  PS1+="$SPLITBAR"
  PS1+="[${c_blue}\w${c_gray}]\n"
  PS1+="${c_gray}$CONNECTBAR_UP "

  # Color reset
  PS1+="${c_reset}"
}

PROMPT_DIRTRIM=4
PROMPT_COMMAND="precmd;compile_prompt;$PROMPT_COMMAND"


# Environment variables
#######################
export EDITOR="kak"
export PAGER="less"


# Aliases
#########
alias ls="ls --color"
alias ll="ls -Al"
alias lx="ls -AgohXL --group-directories-first"
alias vim="nvim"
alias fd="fdfind"
alias top="vtop --theme wizard"
alias grep="grep --color"
alias dev=". .startup.sh"

alias mdserve="sudo -E grip 80 &>/dev/null"
alias mdkill="sudo -E pkill grip"

## Executes sudo -E for nvim so it loads with user config and not root config
## Otherwise behaves like regular sudo command
sudo() {
    if [[ $1 == "vim" ]] || [[ $1 == "nvim" ]] || [[ $1 == "kak" ]]; then
        command sudo -E $1 "${@:2}"
    else
        command sudo "$@"
    fi
}

## tks       => tmux kill-server
## tks -a    => tmux kill-session -a
## tks 1     => tmux kill-session -t 1
tks() {
    if [ -z ${1+x} ]; then
        tmux kill-server
    else
        [ ${1:0:1} == "-" ] && tmux kill-session $1 || tmux kill-session -t $1
    fi
}

## Tmux: Update environment variables for eg. SSH sessions
tmux-env() {
    local v
    while read v; do
        if [[ $v == -* ]]; then
            unset ${v/#-/}
        else
            # Add quotes around the argument
            v=${v/=/=\"}
            v=${v/%/\"}
            eval export $v
        fi
    done < <(tmux show-environment)
}

## Docker: clean <none> images
dockerclean() {
    images=$(docker images -q -f "dangling=true" | tr '\n' ' ')
    if [ ! -z ${images// } ]; then
        echo -e "\e[01mDeleting images:\e[00m"
        docker rmi $images
    fi
}

## Run program in background and disown
bgrun() {
    $@ &> /dev/null &
    disown $!
}
complete -c bgrun   # Enable completion for this command

## Run jupyter notebook in the background (use virtualenv py36 if none are active)
jnb() {
  [ -z ${VIRTUAL_ENV+x} ] && workon py36
  jupyter notebook $@ &> /dev/null &
}


# Sourcing local bashrc
#######################
if [ -f ${HOME}/.config/local.bashrc ]; then
    source "${HOME}/.config/local.bashrc"
fi


# FZF settings
##############
if [ -f "${HOME}/.config/fzf.bashrc" ]; then
    source "${HOME}/.config/fzf.bashrc"
fi


# Sourcing Dir Colors
#####################
if [ -f "${HOME}/.dir_colors" ]; then
    eval "$(dircolors ${HOME}/.dir_colors)"
fi


# Completion in Interactive Shells
##################################
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Sourcing virutalenvwrapper
############################
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    if [ -f /usr/local/bin/virtualenvwrapper_lazy.sh ]; then
        export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
        source /usr/local/bin/virtualenvwrapper_lazy.sh
    else
        source /usr/local/bin/virtualenvwrapper.sh
    fi
fi


# Sourcing cargo
################
if [ -f "${HOME}/.cargo/env" ]; then
    source "${HOME}/.cargo/env"
fi


# Tmux autostart
################
if [ -z "$TMUX" ] && [ -n "${AUTO_TMUX}" ] && [ "${AUTO_TMUX}" != "0" ] && [ -z "$SSH_CONNECTION" ]; then
    if command -v tmux &> /dev/null; then
        tmux has && exec tmux attach || exec tmux
    fi
fi
