{ ... }:

{
  # I define these aliases here so that I get them regardless of which shell I use.
  programs.zsh.shellAliases = {
    # These make it marginally more difficult to shoot myself in the foot
    rm="rm -i";
    cp="cp -i";

    # Useful default replacement commands
    cat="bat";

    # Default to df being human readable
    df="df -h";

    # Some useful Terraform aliases
    tf="terraform";
    tfa="terraform apply";
    tfc="terraform console";
    tfd="terraform destroy";
    tff="terraform fmt";
    tfg="terraform graph";
    tfim="terraform import";
    tfi="terraform init";
    tfo="terraform output";
    tfp="terraform plan";
    tfpr="terraform providers";
    tfr="terraform refresh";
    tfsh="terraform show";
    tft="terraform taint";
    tfut="terraform untaint";
    tfv="terraform validate";
    tfw="terraform workspace";
    tfs="terraform state";
    tffu="terraform force-unlock";
    tfwst="terraform workspace select";
    tfwsw="terraform workspace show";
    tfssw="terraform state show";
    tfwde="terraform workspace delete";
    tfwls="terraform workspace list";
    tfsls="terraform state list";
    tfwnw="terraform workspace new";
    tfsmv="terraform state mv";
    tfspl="terraform state pull";
    tfsph="terraform state push";
    tfsrm="terraform state rm";
    tfay="terraform apply -auto-approve";
    tfdy="terraform destroy -auto-approve";
    tfiu="terraform init -upgrade";
    tfpde="terraform plan --destroy";

    tg="terragrunt";
    dotcfg="$EDITOR $DOTFILES";
    config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
    kctx="kubectx";
    kns="kubens";
    mp="man-preview";
    myip="curl http://ipecho.net/plain; echo";
    ports="netstat -tulanp";
    ffs="sudo !!";
    "in"="task add +in";
    think="tickle +1d";
    tick="tickle";
    rnr="read_and_review";
    rnd="task add +rnd +next +@computer +@online";
    h="history";
    # alias j="jobs -l" seems to be making autojump not work

    # enable color support of ls and also add handy aliases
    dir="dir --color=auto";
    vdir="vdir --color=auto";
    grep="grep --color=auto";
    fgrep="fgrep --color=auto";
    egrep="egrep --color=auto";

    ## A couple of useful ls aliases
    l="ls";

    ## a quick way to get out of current directory ##
    ".."="cd ..";
    "..."="cd ../../";
    "...."="cd ../../../";
    "....."="cd ../../../../";
    ".3"="cd ../../";
    ".4"="cd ../../../";
    ".5"="cd ../../../..";

    ### Python Related Aliases
    pip="python -m pip";

    ### Other Aliases
    wttr="curl wttr.in";
  };
}