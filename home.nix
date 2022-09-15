{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/navi.nix
    ./modules/starship.nix
    ./modules/zsh.nix
  ];
  programs.home-manager.enable = true;
  home.stateVersion = "22.05";

  # Man pages
  manual.manpages.enable = true;

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
    enableGitCredentialHelper = true;
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
    extensions = [
 
    ];
  };

  home.packages = with pkgs; [
    # Some basic tools and utilities
    coreutils
    direnv
    nix-direnv
    jq
    wget2

    # Languages, Language Tools, and Language Packages/Modules
    git
    gh
    bfg-repo-cleaner
    go_1_18
    lua5_4
    nodejs
    nodePackages.npm
    python310
    python310Packages.numpy

    # pipenv # Is this even needed in nix?
    pylint
    tcl
    tk

    # Shells, utilities, customizations and terminals
    # byobu # need a nix-y way of getting libnewt
    iterm2
    oh-my-zsh
    starship
    terminal-notifier
    tmux
    zplug
    zsh
    zsh-completions
    nix-zsh-completions

    # Container Stuff
    docker-compose
    docker-machine
    docker-machine-hyperkit
    dive
    kubectl
    #kubectx #broken with latest nix-pkgs.  Looking at kubie as a replacement so did not look too deeply.
    kops
    kubernetes-helm
    popeye
    stern

    # Cloud stuff
    google-cloud-sdk
    pulumi-bin
    terraform
    terraformer
    terragrunt
    tflint

    # Useful CLI utilities
    autojump
    bitwarden-cli
    lsd
    htop
    httpie

    # Building a second Brain
    obsidian
    pandoc
    #pandoc-drawio-filter

    # Other Applications
    neovim
    vim
    nmap
    openssh
    ripgrep-all
    sops
    speedtest-cli
    sqlite
    taskwarrior
    tealdeer
    unbound
    vim

    # yubikey related tools and utilities
    pinentry
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
    # comma # run software without installing it
    niv # easy dependency management for nix projects
    nodePackages.node2nix

  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];
}
