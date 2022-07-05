{ config, pkgs, ... }:

{
    programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    completionInit = "autoload -U compinit && compinit";
    envExtra = "
      if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR='vim'
      else
        export EDITOR='code -w'
      fi
    ";
    initExtra = ""#''
      #. ~/.zshrc.nixbackup
    ;#'';
    shellAliases = {
      # These make it marginally more difficult to shoot myself in the foot
      rm = "rm -i";
      cp = "cp -i";

      # Default to df being human readable
      df = "df -h";

      # Some useful Terraform aliases
      tf = "terraform";
      tfa = "terraform apply";
      tfc = "terraform console";
      tfd = "terraform destroy";
      tff = "terraform fmt";
      tfg = "terraform graph";
      tfim = "terraform import";
      tfi = "terraform init";
      tfo = "terraform output";
      tfp = "terraform plan";
      tfpr = "terraform providers";
      tfr = "terraform refresh";
      tfsh = "terraform show";
      tft = "terraform taint";
      tfut = "terraform untaint";
      tfv = "terraform validate";
      tfw = "terraform workspace";
      tfs = "terraform state";
      tffu = "terraform force-unlock";
      tfwst = "terraform workspace select";
      tfwsw = "terraform workspace show";
      tfssw = "terraform state show";
      tfwde = "terraform workspace delete";
      tfwls = "terraform workspace list";
      tfsls = "terraform state list";
      tfwnw = "terraform workspace new";
      tfsmv = "terraform state mv";
      tfspl = "terraform state pull";
      tfsph = "terraform state push";
      tfsrm = "terraform state rm";
      tfay = "terraform apply -auto-approve";
      tfdy = "terraform destroy -auto-approve";
      tfiu = "terraform init -upgrade";
      tfpde = "terraform plan --destroy";

      tg = "terragrunt";
      dotcfg = "$EDITOR $DOTFILES";
      config = "/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
      kctx = "kubectx";
      kns = "kubens";
      mp = "man-preview";
      myip = "curl http://ipecho.net/plain; echo";
      ports = "netstat -tulanp";
      ffs = "sudo !!";
      "in" = "task add +in";
      think = "tickle +1d";
      tick = "tickle";
      rnr = "read_and_review";
      rnd = "task add +rnd +next +@computer +@online";
      h = "history";
      j = "jobs -l";

      # enable color support of ls and also add handy aliases
      dir = "dir --color=auto";
      ls = "ls --color=auto";
      vdir = "vdir --color=auto";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";

      # A couple of useful ls aliases
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";

      ## a quick way to get out of current directory ##
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      ".3" = "cd ../../";
      ".4" = "cd ../../../";
      ".5" = "cd ../../../..";

      ### Python Related Aliases
      pip = "python -m pip'";
    };
    shellGlobalAliases = {
        #Global Aliases
        L = "| less";
        G = "| grep";
    };
    sessionVariables = {
      # Set up some personal ENVVARS
      DOTFILES = "$HOME/.dotfiles";
      # Enable Colors in our CLI
      CLICOLOR = 1;
      # Disable fuzzy search for kubectx/kubens
      KUBECTX_IGNORE_FZF = 1;
      # Display red dots whilst waiting for completions
      COMPLETION_WAITING_DOTS = "true";
      # Work around macos's stupid broken ssh-agent
      SSH_AUTH_SOCK = "/usr/local/var/run/yubikey-agent.sock";
      # Disable marking untracked files as dirty. 
      # Major speed improvement for git status on large repos
      DISABLE_UNTRACKED_FILES_DIRTY = "true";
      # History command time stamp format
      HIST_STAMPS = "mm/dd/yyyy";
      # Zsh Autosuggest strategy using histdb
      # ZSH_AUTOSUGGEST_STRATEGY = "histdb_top_here";
      # Uncomment the following line to disable 'column' command 2048 limit workaround
      HISTDB_TABULATE_CMD = "(sed -e $'s/\x1f/\t/g')";
    };
    zplug = {
      enable = true;
      plugins = [
        # Set up our theme
        { name = "~/.dracula-pro.zsh-theme"; tags = [ from:local as:theme ]; }

        # Oh-my-zsh Plugins
        { name = "plugins/aliases"; tags = [ from:oh-my-zsh ]; }
        { name = "plugins/brew"; tags = [ from:oh-my-zsh ]; }
        { name = "plugins/direnv"; tags = [ from:oh-my-zsh ]; }
        { name = "plugins/git"; tags = [ from:oh-my-zsh ]; }
        { name = "plugins/httpie"; tags = [ from:oh-my-zsh ]; }
        { name = "plugins/kubectl"; tags = [ from:oh-my-zsh ]; }
        { name = "plugins/gcloud"; tags = [ from:oh-my-zsh ]; }
        { name = "plugins/alias-finder"; tags = [ from:oh-my-zsh ]; }
        { name = "plugins/bgnotify"; tags = [ from:oh-my-zsh ]; }
        { name = "lib/*.zsh"; tags = [ from:oh-my-zsh ]; }

        # ZPlug GitHub Modules
        # This is handled by the installed fzf package now
        #{ name = "junegunn/fzf"; tags = [ from:github as:plugin rename-to:fzf "use:'*\$\{(L)$(uname -s)}*amd64*'" ]; }
        #{ name = "junegunn/fzf"; tags = [ ''use:"*.zsh"'' defer:2 ]; }
        { name = "larkery/zsh-histdb"; tags = [ from:github as:plugin rename-to:histdb "use:'*.zsh'" ]; }
        { name = "skywind3000/z.lua"; tags = [ from:github as:plugin defer:2 ]; }
        { name = "djui/alias-tips"; tags = [ from:github as:plugin]; }

        # ZPlug Local Modules
        { name = "\${HOME}/.nix-profile/google-cloud-sdk"; tags = [ from:local "use:'*.zsh.inc'" defer:2 ]; }
      ];
    };
  };
}