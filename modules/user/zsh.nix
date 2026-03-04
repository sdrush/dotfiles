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
    rev = "53a26e287fbbe2dcebb3aa1801546c6de32416fa";
    sha256 = "sha256-MFlvAnPCknSgkW3RFA8pfxMZZS/JbyF3aMsJj9uHHVU=";
  };
  zsh-notify = pkgs.fetchFromGitHub {
    owner = "marzocchi";
    repo = "zsh-notify";
    rev = "9c1dac81a48ec85d742ebf236172b4d92aab2f3f";
    sha256 = "sha256-ovmnl+V1B7J/yav0ep4qVqlZOD3Ex8sfrkC92dXPLFI=";
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
    envExtra = lib.mkOrder 0 (
      ''
        if [[ -n $SSH_CONNECTION ]]; then
          export EDITOR='nvim'
        else
          export EDITOR='agy'
        fi

        # Source Cachix token from sops-nix template
        if [[ -f "${config.sops.templates."cachix-token".path}" ]]; then
          source "${config.sops.templates."cachix-token".path}"
        fi

        # Performance tweaks
        export ZSH_DISABLE_COMPFIX="true"
      ''
      + lib.optionalString pkgs.stdenv.isDarwin ''
        # Initialize Homebrew
        if [[ -f /opt/homebrew/bin/brew ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -f /usr/local/bin/brew ]]; then
          eval "$(/usr/local/bin/brew shellenv)"
        fi
      ''
    );

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # Mock compaudit - saves ~25ms auditing the Nix store
        compaudit() { return 0 }

        source ${zsh-defer}/zsh-defer.plugin.zsh

        # SSH agent configuration
        export AGENT_SOCK_SECRETIVE="/Users/${config.home.username}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
        export AGENT_SOCK_YUBIKEY="/usr/local/var/run/yubikey-agent.sock"

        ss-secretive() {
          export SSH_AUTH_SOCK="$AGENT_SOCK_SECRETIVE"
          echo "SSH Agent: Secretive (Enclave)"
        }
        ss-yubikey() {
          export SSH_AUTH_SOCK="$AGENT_SOCK_YUBIKEY"
          echo "SSH Agent: YubiKey"
        }

        # Set default
        ss-secretive
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
        zsh-defer source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/kubectl/kubectl.plugin.zsh"
        zsh-defer source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/gcloud/gcloud.plugin.zsh"
        zsh-defer source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/direnv/direnv.plugin.zsh"

        # zsh-notify
        if [[ "$OSTYPE" == "darwin"* ]]; then
          # The plugin checks for iTerm.app or Apple_Terminal during sourcing.
          # We temporarily spoof it so it loads correctly.
          local OLD_TP="$TERM_PROGRAM"
          export TERM_PROGRAM="iTerm.app"
          source ${zsh-notify}/notify.plugin.zsh
          export TERM_PROGRAM="$OLD_TP"
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
          # On Linux, zsh-notify uses 'notify-send' if available.
          # We don't need to spoof TERM_PROGRAM for Linux backends.
          source ${zsh-notify}/notify.plugin.zsh
        fi
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
      # Disable marking untracked files as dirty.
      # Major speed improvement for git status on large repos
      DISABLE_UNTRACKED_FILES_DIRTY = "true";
    }
    // {
      # History command time stamp format
      HIST_STAMPS = "mm/dd/yyyy";
      # Zsh Autosuggest strategy using histdb
      ZSH_AUTOSUGGEST_STRATEGY = "histdb_top_here";
      # Uncomment the following line to disable 'column' command 2048 limit workaround
      # HISTDB_TABULATE_CMD = "(sed -e $'s/\x1f/\t/g')";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
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
      {
        name = "zsh-abbr";
        src = pkgs.zsh-abbr;
        file = "share/zsh/zsh-abbr/zsh-abbr.zsh";
      }
    ];
  };
}
