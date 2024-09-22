{ config, pkgs, ... }:

{
    programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    completionInit = "autoload -U compinit && compinit";
    envExtra = "
    export SSH_AUTH_SOCK=/Users/sdrush/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
      if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR='vim'
      else
        export EDITOR='code'
      fi
    ";
    initExtraBeforeCompInit = ''
      fpath+=( /etc/profiles/per-user/shannon.rush/share/zsh/site-functions \
      /etc/profiles/per-user/shannon.rush/share/zsh/vendor-completions )
    '';
    initExtra = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
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
      # Set up our CLOUD_SDK_HOME for the gcloud cloud cli
      CLOUD_SDK_HOME="${pkgs.google-cloud-sdk}";
      USE_GKE_GCLOUD_AUTH_PLUGIN="true";
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
      # HISTDB_TABULATE_CMD = "(sed -e $'s/\x1f/\t/g')";
    };
    zplug = {
      enable = true;
      plugins = [
        # Set up our theme
        # { name = "~/.dracula-pro.zsh-theme"; tags = [ from:local as:theme ]; }

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
        # { name = "\${HOME}/.nix-profile/google-cloud-sdk"; tags = [ from:local "use:'*.zsh.inc'" defer:2 ]; }
      ];
    };
  };
}