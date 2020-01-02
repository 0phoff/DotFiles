# Setup fzf
# ---------
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
if [[ ! "$PATH" == */home/top/.fzf/bin* ]]; then
  export PATH="$PATH:/home/top/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/top/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
#source "/home/top/.fzf/shell/key-bindings.bash"
