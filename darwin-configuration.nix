{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep <packagename>
  environment.systemPackages =
    [ 
      pkgs.python2
      pkgs.wget
    ];

  nixpkgs.config.allowUnfree = true;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Set up our Hostname
  networking.hostName = "hyperion";

  # imports = [ <home-manager/nixos> ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix.extraOptions = "
      experimental-features = nix-command flakes
   ";
   
  nix.package = pkgs.nixUnstable;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  # Enable one of these for alternative shells
  # programs.bash.enable = true;
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  imports = [ <home-manager/nix-darwin> ];

  users.users."shannon.rush" = {
    name = "shannon.rush";
    home = "/Users/shannon.rush";
  };

  home-manager.users."shannon.rush" = { pkgs, ...}: {
    programs.home-manager.enable = true;
    manual.manpages.enable = true;
    home.stateVersion = "21.05";
    home.packages = with pkgs; [
      # Languages, Language Tools, and Language Packages/Modules
      go_1_18
      lua5_4
      nodejs
      nodePackages.npm
      python310
      python310Packages.numpy
      pipenv
      pylint
      tcl
      tk

      # Shells and Shell Customizations
      zsh
      zsh-completions
      nix-zsh-completions
      oh-my-zsh
      zplug

      # Container Stuff
      docker-compose
      docker-machine
      docker-machine-hyperkit
      dive
      kubectl
      kubectx
      kops
      kubernetes-helm
      popeye
      stern

      autoconf
      autojump
      bfg-repo-cleaner
      bitwarden-cli
      # byobu need to find newtlib for macos outside of brew
      coreutils
      direnv
      nix-direnv

      google-cloud-sdk
      gnupg
      gnutls
      httpie
      iterm2
      jq
      ldns # DNS Library and drill
      lsd
      ncurses
      nghttp2
      neovim
      nmap
      oath-toolkit

      openssh
      openssl
      pinentry
      pinentry_mac
      pulumi-bin
      ripgrep-all
      readline
      sops
      speedtest-cli
      sqlite
      taskwarrior
      terminal-notifier
      terraform
      terraformer
      terragrunt
      tflint
      tmux
      unibilium
      unbound
      vim
      wget2
      yubico-piv-tool
      yubikey-agent
      yubikey-manager
      yubikey-personalization
    ];
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
        "..." = "cd ../../../";
        "...." = "cd ../../../../";
        "....." = "cd ../../../../";
        ".4" = "cd ../../../../";
        ".5" = "cd ../../../../..";

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
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.starship;
      settings = { 
        # Don't print a new line at the start of the prompt
        add_newline = false;
        kubernetes.format = "[$symbol$context\($namespace\)](dimmed green) ";
        kubernetes.disabled = false;
        kubernetes.context_aliases."dev.local.cluster.k8s" = "dev";
        custom.task_inbox.description = "Task Inbox Count";
        custom.task_inbox.when = "[ 'task +in +PENDING count' == '0' ] && exit 1 || exit 0 ";
        custom.task_inbox.command = "task +in +PENDING count";
        custom.task_inbox.format = "$symbol[$output]($style) ";
        custom.task_inbox.shell = "['zsh', '-d', '-f', '-i'] ";
        custom.task_inbox.symbol = "📥 ";
        custom.task_inbox.style = "bold fg:green";
        gcloud.format = "on [$symbol$account(\($project@$region\))]($style) ";
        gcloud.symbol = "☁️ ";
        gcloud.region_aliases.us-central1 = "usc1";
        gcloud.region_aliases.us-east1 = "use1";
        gcloud.region_aliases.us-east4 = "use4";
        gcloud.region_aliases.us-west1 = "usw1";
        gcloud.region_aliases.us-west2 = "usw2";
        gcloud.region_aliases.us-west3 = "usw3";
        gcloud.region_aliases.us-west4 = "usw4";
        gcloud.region_aliases.northamerica-northeast1 = "nane1";
        gcloud.region_aliases.southamerica-east1 = "sae1";
        gcloud.region_aliases.europe-north1 = "eun1";
        gcloud.region_aliases.europe-west1 = "euw1";
        gcloud.region_aliases.europe-west2 = "euw2";
        gcloud.region_aliases.europe-west3 = "euw3";
        gcloud.region_aliases.europe-west4 = "euw4";
        gcloud.region_aliases.europe-west6 = "euw6";
        gcloud.region_aliases.asia-south1 = "as1";
        gcloud.region_aliases.asia-southeast1 = "ase1";
        gcloud.region_aliases.asia-southeast2 = "ase2";
        gcloud.region_aliases.asia-east1 = "ae1";
        gcloud.region_aliases.asia-east2 = "ae2";
        gcloud.region_aliases.asia-northeast1 = "ane1";
        gcloud.region_aliases.asia-northeast2 = "ane2";
        gcloud.region_aliases.asia-northeast3 = "ane3";
      };
    };
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = [
          pkgs.vscode-extensions.bbenoist.nix
          
      ];
    };
    programs.autojump = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.fzf;
    };
    programs.git = {
        enable = true;
        package = pkgs.git;
        userEmail = "shannon.rush@mavenwave.com";
        userName = "Shannon Rush";
        extraConfig = {
          credential.helper = "osxkeychain";
          #credential.helper = 
        };
    };
  };
}

