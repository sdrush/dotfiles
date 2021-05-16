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

# Oh-my-zsh Plugins
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/gcloud", from:oh-my-zsh
zplug "plugins/alias-finder", from:oh-my-zsh
zplug "plugins/bgnotify", from:oh-my-zsh
zplug "lib/*.zsh", from:oh-my-zsh

if [[ $OSTYPE == darwin* ]]; then
  zplug "plugins/iterm", from:oh-my-zsh
  zplug "plugins/brew", from:oh-my-zsh
  zplug "plugins/osx", from:oh-my-zsh
fi

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

if [[ $OSTYPE == darwin* ]]; then
  zplug "${HOME}", from:local, use:".iterm2_shell_integration.zsh"
fi

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
