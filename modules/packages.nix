{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Some basic tools and utilities
    coreutils
    direnv
    nix-direnv
    jq
    yq
    wget2
    gettext
    nixfmt-rfc-style

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
    jujutsu

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
    (google-cloud-sdk.withExtraComponents [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    # google-cloud-sdk
    # pulumi-bin
    terraform # devshell
    terraformer # devshell
    # terragrunt # devshell
    tflint # devshell

    # Useful CLI utilities
    autojump
    # bitwarden-cli 06-03-2024 broken because of use of deprected NIX features
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

  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];
}