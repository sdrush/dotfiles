#!/usr/bin/env zsh

########################################################################
#
# Filename: .dotfiles/zshrc
#
# Tl;dr ~/.zshrc symlinked to ~/.dotfiles/zshrc.  Main zshrc file
#
# Author: Shannon Rush (shannondotrushatgmaildotcom)
# Date: May 2021
#
# Description: 
#   This is the primary .zshrc file and gets symlinked to ~/.zshrc by the
#   bootstrap script.  This script loads all of our common zplug 
#   configuration, aliases and functions.  It also uses zplug local modules
#   to load all of the *.zsh files in the zsh (common), linux, and macos
#   directories.  
#
########################################################################
#
# For profiling zsh: https://unix.stackexchange.com/a/329719/27109
#
# Uncomment the following line to enable the native zsh profiling tool:
# export ZPROF=true
#
########################################################################

if [ $ZPROF ]; then
  zmodload zsh/zprof
fi

# Source our local environment first
source ~/.zshenv

# ZPlug Configuration
source $ZPLUG_HOME/init.zsh

# Set up ZPlug to manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Set up our Cobalt theme
#zplug "wesbos/Cobalt2-iterm", from:github, as:theme, use:"cobalt2.zsh-theme"

# Set up our theme
zplug '~/.dracula-pro.zsh-theme', from:local, as:theme

# Using zplug to load our zshrc, functions and aliases
zplug "${DOTFILES}/zsh", from:local, use:"*.zsh"
if [[ "$OSTYPE" == "darwin"* ]]; then
  zplug "${DOTFILES}/macos", from:local, use:"*.zsh"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  zplug "${DOTFILES}/linux", from:local, use:"*zsh"
fi


# Oh-my-zsh Plugins
zplug "plugins/aliases", from:oh-my-zsh
zplug "plugins/brew", from:oh-my-zsh
zplug "plugins/direnv", from:oh-my-zsh
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
zplug "junegunn/fzf", from:github, as:plugin, rename-to:fzf, use:"*${(L)$(uname -s)}*amd64*"
zplug "junegunn/fzf", use:"*.zsh", defer:2
zplug "larkery/zsh-histdb", from:github, as:plugin, rename-to:histdb, use:"*.zsh"
zplug "skywind3000/z.lua", from:github, as:plugin, defer:2
zplug "djui/alias-tips", from:github, as:plugin

# ZPlug Local Modules
zplug "${HOME}/google-cloud-sdk", from:local, use:"*.zsh.inc", defer:2

# zplug check returns true if all packages are installed, so run install if false
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

# Set up our envvar for minikube docker-env
if command_exists minikube ; then
  eval $(minikube -p minikube docker-env)
fi


#################################################################
# DO NOT ADD LINES BELOW THIS SECTION
# This needs to be the final section for zprof to work correctly
#################################################################
if [ $ZPROF ]; then
  zprof
  export ZPROF=false
fi
