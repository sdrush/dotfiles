#!/usr/bin/env zsh

# vim:syntax=zsh
# vim:filetype=zsh

# for profiling zsh
# https://unix.stackexchange.com/a/329719/27109
#
################################################
# Uncomment the following line to enable the native zsh profiling tool
#export ZPROF=true
################################################
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

# Using zplug to load all our os-specific zshrc, functions and aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
  zplug "${DOTFILES}/macos", from:local, use:"*.zsh"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  zplug "${DOTFILES}/linux", from:local, use:"*zsh"
fi

# Oh-my-zsh Plugins
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/gcloud", from:oh-my-zsh
zplug "plugins/alias-finder", from:oh-my-zsh
zplug "plugins/bgnotify", from:oh-my-zsh
zplug "lib/*.zsh", from:oh-my-zsh

# ZPlug External Modules
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# ZPlug GitHub Modules
zplug "junegunn/fzf", from:gh-r, as:command, rename-to:fzf, use:"*${(L)$(uname -s)}*amd64*"
zplug "junegunn/fzf", use:"shell/*.zsh", defer:2
zplug "larkery/zsh-histdb", from:github, as:plugin, rename-to:histdb, use:"*.zsh"
zplug "skywind3000/z.lua", from:github, as:plugin, defer:2
zplug "djui/alias-tips", from:github, as:plugin

# ZPlug Local Modules
zplug "${HOME}/google-cloud-sdk", from:local, use:"*.zsh.inc", defer:2

# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check ; then
    zplug install
fi

# source plugins 
zplug load # --verbose
autoload -Uz add-zsh-hook

# Enable starship prompt
eval "$(starship init zsh)"

# Hook the shell for direnv
eval "$(direnv hook zsh)"

#################################################################
# DO NOT ADD LINES BELOW THIS SECTION
# This needs to be the final section for zprof to work correctly
#################################################################
if [ $ZPROF ]; then
  zprof
  export ZPROF=false
fi
