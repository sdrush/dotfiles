{
  config,
  pkgs,
  lib,
  ...
}:

let
  zsh-defer = pkgs.fetchFromGitHub {
    owner = "romkatv";
    repo = "zsh-defer";
    rev = "master";
    sha256 = "sha256-MFlvAnPCknSgkW3RFA8pfxMZZS/JbyF3aMsJj9uHHVU=";
  };
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # Skip the slow compaudit check and use a cache file
    completionInit = ''
      autoload -U compinit
      if [[ -n ''${ZDOTDIR:-''$HOME}/.zcompdump(#qN.m-1) ]]; then
        compinit -u -C
      else
        compinit -u
      fi
    '';
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    envExtra = "
    export SSH_AUTH_SOCK=/Users/${config.home.username}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
      if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR='nvim'
      else
        export EDITOR='agy'
      fi

      # Performance tweaks
      export ZSH_DISABLE_COMPFIX=\"true\"
    ";

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # Mock compaudit - saves ~25ms auditing the Nix store
        compaudit() { return 0 }

        source ${zsh-defer}/zsh-defer.plugin.zsh
      '')
      (lib.mkOrder 500 ''
        fpath+=( /etc/profiles/per-user/${config.home.username}/share/zsh/site-functions \
        /etc/profiles/per-user/${config.home.username}/share/zsh/vendor-completions )

        # Defer the slow vi-mode
        zsh-defer source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

        # fzf-tab configuration
        zstyle ':completion:*:git-checkout:*' sort false
        zstyle ':completion:*:descriptions' format '[%d]'
        zstyle ':completion:*' list-colors ""
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
        zstyle ':fzf-tab:*' switch-group '<' '>'

        # zsh-history-substring-search bindings
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
        bindkey -M vicmd 'k' history-substring-search-up
        bindkey -M vicmd 'j' history-substring-search-down
      '')
      (lib.mkOrder 900 ''
        # Lazy load heavy OMZ plugins
        zsh-defer source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/brew/brew.plugin.zsh"
        zsh-defer source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/kubectl/kubectl.plugin.zsh"
        zsh-defer source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/gcloud/gcloud.plugin.zsh"
        zsh-defer source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/direnv/direnv.plugin.zsh"
        zsh-defer source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/httpie/httpie.plugin.zsh"
        zsh-defer source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/bgnotify/bgnotify.plugin.zsh"
        zsh-defer source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/aliases/aliases.plugin.zsh"
      '')
    ];
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
        "git"
        "alias-finder"
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
