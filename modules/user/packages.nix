{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Some basic tools and utilities
    coreutils
    wget2
    gettext
    nixfmt-rfc-style
    yq
    manix

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
    pylint
    tcl
    tk

    # Shells, utilities, customizations and terminals
    byobu
    terminal-notifier
    jira-cli-go

    # Container Stuff
    docker-compose
    dive
    kubectl # devshell
    kubectx # devshell 
    kops # devshell
    kubernetes-helm # devshell
    popeye # devshell
    stern # devshell

    # Cloud stuff
    (google-cloud-sdk.withExtraComponents [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    terraform # devshell
    terraformer # devshell
    terragrunt # devshell
    tflint # devshell

    # Useful CLI utilities
    bitwarden-cli
    httpie #no worky with python310

    # Building a second Brain
    pandoc

    # Other Applications
    grex # Generate regukar expressions from user generated test cases
    gcalcli # cli for Google Calendar
    nmap
    openssh
    sops # Secure operations
    age # Secure encryption
    speedtest-cli
    sqlite
    unbound
    
    # yubikey related tools and utilities
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
    nh # Nix Helper
    nix-output-monitor # A cleaner build output
    statix # Linter and suggestions for the nix language
    deadnix # Find and remove unused code in .nix source files
    nix-tree # Vizualize the dependency graph (great for debugging size)

  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];
}