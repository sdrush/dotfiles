#!/usr/bin/env zsh

########################################################################
#
# Filename: .dotfiles/zsh/aliases.zsh
#
# Tl;dr Common aliases.  Run by zshrc as a zplug local module
#
# Author: Shannon Rush (shannondotrushatgmaildotcom)
# Date: May 2021
#
########################################################################

# These make it marginally more difficult to shoot myself in the foot
alias rm='rm -i'
alias cp='cp -i'

# Default to df being human readable
alias df='df -h'

alias dotcfg='$EDITOR $DOTFILES'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias kctx='kubectx'
alias kns='kubens'
alias mp='man-preview'
alias myip="curl http://ipecho.net/plain; echo"
alias ports='netstat -tulanp'
alias ffs='sudo !!'
alias in='task add +in'
alias think='tickle +1d'
alias tick='tickle'
alias rnr='read_and_review'
alias rnd='task add +rnd +next +@computer +@online'
alias h='history'
alias j='jobs -l'

#Global Aliases
alias -g L='| less'
alias -g G='| grep'

# Suffix Aliases
alias -s {zip,ZIP}="unzip -l"
alias -s {md,MD,txt,TXT}='code'

# enable color support of ls and also add handy aliases
export CLICOLOR=1
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# A couple of useful ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....'cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

### Python Related Aliases
alias pip='python -m pip'
