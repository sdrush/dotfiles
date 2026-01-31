{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    completionInit = "autoload -U compinit && compinit";
    envExtra = "
    export SSH_AUTH_SOCK=/Users/${config.home.username}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
      if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR='nvim'
      else
        export EDITOR='agy'
      fi
    ";
    initContent = lib.mkOrder 550 ''
      fpath+=( /etc/profiles/per-user/${config.home.username}/share/zsh/site-functions \
      /etc/profiles/per-user/${config.home.username}/share/zsh/vendor-completions )
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      # fzf-tab configuration
      # disable sort when completing `git checkout`
      zstyle ':completion:*:git-checkout:*' sort false
      # set descriptions format to enable group support
      # NOTE: don't use escape sequences here, fzf-tab will handle them for you
      zstyle ':completion:*:descriptions' format '[%d]'
      # set list-colors to enable filename colorizing
      zstyle ':completion:*' list-colors ""
      # preview directory's content with eza when completing cd
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
      # switch group using `<` and `>`
      zstyle ':fzf-tab:*' switch-group '<' '>'

      # zsh-history-substring-search bindings
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      bindkey -M vicmd 'k' history-substring-search-up
      bindkey -M vicmd 'j' history-substring-search-down
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
      CLOUD_SDK_HOME = "${pkgs.google-cloud-sdk}";
      USE_GKE_GCLOUD_AUTH_PLUGIN = "true";
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
    oh-my-zsh = {
      enable = true;
      plugins = [
        "aliases"
        "brew"
        "direnv"
        "git"
        "httpie"
        "kubectl"
        "gcloud"
        "alias-finder"
        "bgnotify"
      ];
    };
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "zsh-histdb";
        src = pkgs.zsh-histdb;
        file = "share/zsh-histdb/sqlite-history.zsh";
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.zsh-history-substring-search;
        file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
      }
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh-autopair/autopair.zsh";
      }
      {
        name = "zsh-you-should-use";
        src = pkgs.zsh-you-should-use;
        file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
      }
    ];
  };
}
