# Setup fzf
# ---------
if [[ ! "$PATH" == */home/top/.fzf/bin* ]]; then
  export PATH="$PATH:/home/top/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/top/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/top/.fzf/shell/key-bindings.bash"
