#!/usr/bin/env zsh

########################################################################
#
# Filename: .dotfiles/macos/functions.zsh
#
# Tl;dr MacOS Specific functions file.  Run from zshrc by zplug
#
# Author: Shannon Rush (shannondotrushatgmaildotcom)
# Date: May 2021
#
########################################################################

# Open Google search from the terminal
google() {
    open /Applications/Google\ Chrome.app/ "http://www.google.com/search?q= $1"
}

# Give me a reasonabile view for ssh-add -l
ssh-add_wf ()
{
    while read -r line; do
        for file in ~/.ssh/*.pub;
        do
            printf "%s %s\n" "$(ssh-keygen -lf "$file" | awk '{$1=""}1')" "$file";
        done | column -t | grep --color=auto "$line" || echo "$line";
    done < <(ssh-add -l | awk '{print $2}')
}
