# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/zplug/bin/fzf* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/zplug/bin/fzf"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
