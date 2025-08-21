{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/navi.nix
    ./modules/starship.nix
    ./modules/tmux.nix
    ./modules/zsh.nix
    ./git
  ];
  programs.home-manager.enable = true;
  home.stateVersion = "22.05";

  # Man pages
  manual.manpages.enable = true;

  # Alacritty
  # https://github.com/alacritty/alacritty
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.alacritty.enable
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
  };


  # Autojump: a cd command that learns.
  # https://github.com/wting/autojump
  # https://rycee.gitlab.io/home-manager/optio/ns.html#opt-programs.autojump.enable
  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

  # Direnv: load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # FZF: Fuzzy search
  # https://github.com/junegunn/fzf
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.fzf.enable
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.fzf;
  };

  # GH: The github cli
  # https://cli.github.com/
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.gh.enable
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    package = pkgs.gh;
  };

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  # VSCode: Visual Studio Code
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default.extensions = [
 
    ];
  };

  home.sessionPath = [
    "/~.rd/bin"
  ];

  home.packages = with pkgs; [
    # Some basic tools and utilities
    coreutils
    direnv
    nix-direnv
    jq
    yq
    wget2
    gettext

    # Languages, Language Tools, and Language Packages/Modules
    bfg-repo-cleaner
    go
    lua5_4
    nodejs_22
    python312
    python312Packages.numpy
    python312Packages.pyopenssl
    graphviz
    temurin-jre-bin-17

    # pipenv # Is this even needed in nix?
    pylint
    tcl
    tk

    # Shells, utilities, customizations and terminals
    #byobu # need a nix-y way of getting libnewt
    # iterm2
    oh-my-zsh
    starship
    terminal-notifier
    tmux
    zplug
    zsh
    zsh-completions
    nix-zsh-completions
    jira-cli-go

    # Container Stuff
    docker-compose
    #docker-machine
    # docker-machine-hyperkit
    dive
    kubectl # devshell
    kubectx # devshell 
    kops # devshell
    kubernetes-helm # devshell
    popeye # devshell
    stern # devshell

    # Cloud stuff
    (google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin])
    # google-cloud-sdk
    # pulumi-bin
    terraform # devshell
    terraformer # devshell
    terragrunt # devshell
    tflint # devshell

    # Useful CLI utilities
    autojump
    # bitwarden-cli 06-03-2024 broken because of use of deprected NIX features
    lsd
    htop
    # httpie no worky with python310

    # Building a second Brain
    #obsidian 03-07-2025 managed by brew
    pandoc
    #pandoc-drawio-filter

    # Other Applications
    zellij # terminal multiplexer
    bat # a better cat
    grex # Generate regukar expressions from user generated test cases
    gcalcli # cli for Google Calendar
    neovim
    vim
    nmap
    openssh
    ripgrep
    sops
    speedtest-cli
    sqlite
    taskwarrior3
    tealdeer
    unbound
    vim

    # yubikey related tools and utilities
    #pinentry
    pinentry_mac
    yubico-piv-tool
    yubikey-agent
    yubikey-manager
    yubikey-personalization

    # Libraries
    autoconf
    gnupg
    gnutls
    ldns # DNS Library and drill
    ncurses
    nghttp2
    oath-toolkit
    openssl
    readline
    unibilium

    # Some useful nix related tools
    cachix # adding/managing alternative binary caches hosted by Cachix
    comma # run software without installing it
    niv # easy dependency management for nix projects
    # nodePackages.node2nix Commented for testing

  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];
  home.file = { 
    ".config/alacritty/alacritty.yml".source = ./alacritty.yml;
    # ".warp/workflows/gcloud/set_project.yaml".source = ./set_project.yaml;
  };
}
