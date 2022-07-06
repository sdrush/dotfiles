{ config, pkgs, ... }:

{
  # I define these aliases here so that I get them regardless of which shell I use.
  environment.interactiveShellInit=''
    # These make it marginally more difficult to shoot myself in the foot
    alias rm="rm -i"
    alias cp="cp -i"

    # Default to df being human readable
    alias df="df -h"

    # Some useful Terraform aliases
    alias tf="terraform"
    alias tfa="terraform apply"
    alias tfc="terraform console"
    alias tfd="terraform destroy"
    alias tff="terraform fmt"
    alias tfg="terraform graph"
    alias tfim="terraform import"
    alias tfi="terraform init"
    alias tfo="terraform output"
    alias tfp="terraform plan"
    alias tfpr="terraform providers"
    alias tfr="terraform refresh"
    alias tfsh="terraform show"
    alias tft="terraform taint"
    alias tfut="terraform untaint"
    alias tfv="terraform validate"
    alias tfw="terraform workspace"
    alias tfs="terraform state"
    alias tffu="terraform force-unlock"
    alias tfwst="terraform workspace select"
    alias tfwsw="terraform workspace show"
    alias tfssw="terraform state show"
    alias tfwde="terraform workspace delete"
    alias tfwls="terraform workspace list"
    alias tfsls="terraform state list"
    alias tfwnw="terraform workspace new"
    alias tfsmv="terraform state mv"
    alias tfspl="terraform state pull"
    alias tfsph="terraform state push"
    alias tfsrm="terraform state rm"
    alias tfay="terraform apply -auto-approve"
    alias tfdy="terraform destroy -auto-approve"
    alias tfiu="terraform init -upgrade"
    alias tfpde="terraform plan --destroy"

    alias tg="terragrunt"
    alias dotcfg="$EDITOR $DOTFILES"
    alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
    alias kctx="kubectx"
    alias kns="kubens"
    alias mp="man-preview"
    alias myip="curl http://ipecho.net/plain; echo"
    alias ports="netstat -tulanp"
    alias ffs="sudo !!"
    alias "in"="task add +in"
    alias think="tickle +1d"
    alias tick="tickle"
    alias rnr="read_and_review"
    alias rnd="task add +rnd +next +@computer +@online"
    alias h="history"
    alias j="jobs -l"

    # enable color support of ls and also add handy aliases
    alias dir="dir --color=auto"
    alias ls="ls --color=auto -F"
    alias vdir="vdir --color=auto"
    alias grep="grep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias egrep="egrep --color=auto"

    ## A couple of useful ls aliases
    alias ll="ls -al"
    alias la="ls -A"
    alias l="ls -C"

    ## a quick way to get out of current directory ##
    alias ".."="cd .."
    alias "..."="cd ../../"
    alias "...."="cd ../../../"
    alias "....."="cd ../../../../"
    alias ".3"="cd ../../"
    alias ".4"="cd ../../../"
    alias ".5"="cd ../../../.."

    ### Python Related Aliases
    alias pip="python -m pip'"
  '';
}