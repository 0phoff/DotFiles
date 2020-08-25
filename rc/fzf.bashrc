# Setup fzf
# ---------
if [[ ! "$PATH" == */home/top/.fzf/bin* ]]; then
  export PATH="$PATH:/home/top/.fzf/bin"
fi

# Options
# -------
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'


# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/top/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
#source "/home/top/.fzf/shell/key-bindings.bash"
