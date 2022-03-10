# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ayush/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ayush/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ayush/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/ayush/.fzf/shell/key-bindings.bash"
