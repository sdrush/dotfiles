#!/usr/bin/env zsh

########################################################################
#
# Filename: .dotfiles/zsh/functions.zsh
#
# Tl;dr Common functions file.  Run from zshrc by zplug
#
# Author: Shannon Rush (shannondotrushatgmaildotcom)
# Date: May 2021
#
########################################################################

# Create a directory and immediately cd to it
take() {
  mkdir -p $@ && cd ${@:$#}
}

# timezsh() gives me a snapshot of zsh load times and performance
timezsh() {
    shell=${1-$SHELL}
    for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# Tickle function to add tickle metadata for tasks and tick alias
tickle() {
    deadline=$1
    shift
    in +tickle wait:$deadline $@
}

webpage_title() {
    wget -qO- "$*" | hxselect -s '\n' -c 'title' 2>/dev/null
}

read_and_review() {
    link="$1"
    title=$(webpage_title $link)
    echo $title
    descr="\"Read and review: $title\""
    id=$(task add +next +rnr "$descr" | sed -n 's/Created task \(.*\)./\1/p')
    task "$id" annotate "$link"
}

# This query will find the most frequently issued command that is issued in the
# current directory or any subdirectory. From https://github.com/larkery/zsh-histdb
_zsh_autosuggest_strategy_histdb_top_here() {
    local query="select commands.argv from 
    history left join commands on history.command_id = commands.rowid 
    left join places on history.place_id = places.rowid 
    where places.dir LIKE '$(sql_escape $PWD)%'
    and commands.argv LIKE '$(sql_escape $1)%'
    group by commands.argv order by count(*) desc limit 1"
    suggestion=$(_histdb_query "$query")
}

# This will find the most frequently issued command issued exactly in this
# directory, or if there are no matches it will find the most frequently issued
# command in any directory. From https://github.com/larkery/zsh-histdb
_zsh_autosuggest_strategy_histdb_top() {
    local query="select commands.argv from
    history left join commands on history.command_id = commands.rowid
    left join places on history.place_id = places.rowid
    where commands.argv LIKE '$(sql_escape $1)%'
    group by commands.argv
    order by places.dir != '$(sql_escape $PWD)', count(*) desc limit 1"
    suggestion=$(_histdb_query "$query")
}

# This keeps our history a little bit cleaner by leaving out commands we dont
# care about.
zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}
    # Only those that satisfy all of the following conditions are added to the history
    [[ ${#line} -ge 5 && \
    ${cmd} != ll && \
    ${cmd} != ls && \
    ${cmd} != la && \
    ${cmd} != cd && \
    ${cmd} != man && \
    ${cmd} != scp && \
    ${cmd} != vim && \
    ${cmd} != nvim && \
    ${cmd} != less && \
    ${cmd} != ping && \
    ${cmd} != open && \
    ${cmd} != file && \
    ${cmd} != which && \
    ${cmd} != whois && \
    ${cmd} != drill && \
    ${cmd} != uname && \
    ${cmd} != md5sum && \
    ${cmd} != pacman && \
    ${cmd} != xdg-open && \
    ${cmd} != traceroute && \
    ${cmd} != speedtest-cli ]]

}
