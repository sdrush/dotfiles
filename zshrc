# Uncomment the following line to enable the native zsh profiling tool
#export ZPROF=true
if [ $ZPROF ]; then
  zmodload zsh/zprof
fi

# Source our environment first
source ~/.zshenv

################################################
# ZPlug Configuration
################################################
source $ZPLUG_HOME/init.zsh

# Set up ZPlug to manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Set up our Cobalt theme
zplug "wesbos/Cobalt2-iterm", from:github, as:theme, use:"cobalt2.zsh-theme"

# Source our OS-specific files here
if [[ "$OSTYPE" == "darwin"* ]]; then
  source $DOTFILES/macos/macos.zshrc
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  source $DOTFILES/linux/linux.zshrc
elif [[ "$OSTYPE" == "cygwin" ]]; then
  # I'm not even sure I'm going to do the work for Cygwin.  This is 
  # mostly for historical purposes
elif [[ "$OSTYPE" == "msys" ]]; then
  # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "win32" ]]; then
  # I'm not sure this can happen.
fi

# Oh-my-zsh Plugins
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/gcloud", from:oh-my-zsh
zplug "plugins/alias-finder", from:oh-my-zsh
zplug "plugins/bgnotify", from:oh-my-zsh
zplug "lib/*.zsh", from:oh-my-zsh

# ZPlug External Modules
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# ZPlug GitHub Modules
zplug "junegunn/fzf", from:gh-r, as:command, rename-to:fzf, use:"*${(L)$(uname -s)}*amd64*"
zplug "junegunn/fzf", use:"shell/*.zsh", defer:2
zplug "larkery/zsh-histdb", from:github, as:plugin, rename-to:histdb, use:"*.zsh"
zplug "skywind3000/z.lua", from:github, as:plugin
zplug "djui/alias-tips", from:gh-r, as:command, rename-to:alias-tips
zplug "djui/alias-tips"

# ZPlug Local Modules
zplug "${HOME}/google-cloud-sdk", from:local, use:"*.zsh.inc"

# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check; then
    zplug install
fi

# source plugins 
zplug load # --verbose
autoload -Uz add-zsh-hook

# Aliases and Functions from dotfiles directory
source $DOTFILES/zsh/aliases
source $DOTFILES/zsh/functions

# Enable starship prompt
eval "$(starship init zsh)"

#################################################################
# DO NOT ADD LINES BELOW THIS SECTION
# This needs to be the final section for zprof to work correctly
#################################################################
if [ $ZPROF ]; then
  zprof
  export ZPROF=false
fi
