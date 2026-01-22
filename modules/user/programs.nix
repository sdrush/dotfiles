{ pkgs, config, ... }:

{
  programs = {
    # Atuin: A better shell history
    # https://github.com/ellie/atuin
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.atuin.enable
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };

    # Bat: A Better Cat
    # https://github.com/sharkdp/bat
    # https://rycee.gitlab.io/home-manager/options.xhtml#opt-programs.bat.enable
    bat = {
      enable = true;
      config = {
        style = "header,grid"; # less clutter than default (which is "full")
        pager = "less -FR"; # Quit if one screen, and supporting colors
      };
    };

    # Btop: A Better Top
    # https://github.com/aristocratos/btop
    # https://rycee.gitlab.io/home-manager/options.xhtml#opt-programs.btop.enable
    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };

    # Delta: A better git diff
    # https://github.com/dandavison/delta
    # https://rycee.gitlab.io/home-manager/options.xhtml#opt-programs.delta.enable
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        line-numbers = true;
        side-by-side = true;
      };
    };

    # Direnv: load and unload environment variables depending on the current directory.
    # https://direnv.net
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # EZA: My favorite maintained ls replacement
    # https://github.com/eza-community/eza
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.eza.enable
    eza = {
      enable = true;
      enableZshIntegration = true;
      icons = "auto";
    };

    # FD: A simpler, faster find
    # https://github.com/sharkdp/fd
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.fd.enable
    fd = {
      enable = true;
      hidden = true;
    };

    # FZF: Fuzzy search
    # https://github.com/junegunn/fzf
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.fzf.enable
    fzf = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.fzf;
    };

    # GH: The github cli
    # https://cli.github.com/
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.gh.enable
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      package = pkgs.gh;
    };

    # GPG: The GNU Privacy Guard
    # https://www.gnupgp.org/
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.gpg.enable
    gpg = {
      enable = true;
    };

    # JQ: JSON processor
    # https://github.com/stedolan/jq
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.jq.enable
    jq = {
      enable = true;
    };

    # K9s: The Kubernetes CLI
    # https://github.com/derailed/k9s
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.k9s.enable
    k9s = {
      enable = true;
    };

    # LazyGit: A better git
    # https://github.com/jesseduffield/lazygit
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.lazygit.enable
    lazygit = {
      enable = true;
    };

    # NH: Nix Helper
    # https://github.com/nix-community/nh
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.nh.enable
    nh = {
      enable = true;
      clean.enable = true;
      clean.dates = "weekly";
      clean.extraArgs = "--keep-since 7d --keep 5";
      flake = "${config.home.homeDirectory}/.dotfiles";
    };

    # Nix Index: A file database for nixpkgs
    # https://github.com/nix-community/nix-index
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.nix-index.enable
    nix-index = {
      enable = true;
    };

    # Ripgrep: Just like grep, only faster
    # https://github.com/BurntSushi/ripgrep
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.ripgrep.enable
    ripgrep = {
      enable = true;
      arguments = [
        "--max-columns-preview"
        "--colors=line:style:bold"
      ];
    };

    # SSH: Secure Shell
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.ssh.enable
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        addKeysToAgent = "yes";
      };
    };

    # TaskWarrior: The Task List Manager
    # https://github.com/GothenburgBitFactory/taskwarrior
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.taskwarrior.enable
    taskwarrior = {
      enable = true;
      package = pkgs.taskwarrior3;
      colorTheme = "dark-256";
    };

    # Tealdeer: A better 'man'
    # https://github.com/dbrgn/tealdeer
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.tealdeer.enable
    tealdeer = {
      enable = true;
      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {
          auto_update = true;
        };
      };
    };

    # VSCode: Visual Studio Code
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.vscode.enable
    vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.default.extensions = [

      ];
    };

    # Yazi: Blazing fast terminal manager written in Rust
    # https://github.com/yazi-org/yazi
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.yazi.enable
    yazi = {
      enable = true;
    };

    # Zellij: Terminal multiplexer
    # https://github.com/zellij-org/zellij
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zellij.enable
    zellij = {
      enable = true;
      enableZshIntegration = true;
    };

    # Zoxide: Smart cd
    # https://github.com/ajeetkumar/zoxide
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd" # Replace 'cd' with 'z' (smart jumping)
      ];
    };
  };
}
