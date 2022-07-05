{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/zsh.nix
    ./modules/starship.nix
  ];
  programs.home-manager.enable = true;
  home.stateVersion = "22.05";

  # Man pages
  manual.manpages.enable = true;

  # Autojump: a cd command that learns.
  # https://github.com/wting/autojump
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.autojump.enable
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
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.fzf;
  };

  # GH: The github cli
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
    # Languages, Language Tools, and Language Packages/Modules
    git
    gh
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

    # Shells and Shell Customizations
    zsh
    zsh-completions
    starship
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
    htop
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
    wget
    wget2
    yubico-piv-tool
    yubikey-agent
    yubikey-manager
    yubikey-personalization

    # Useful nix related tools
    cachix # adding/managing alternative binary caches hosted by Cachix
    # comma # run software from without installing it
    niv # easy dependency management for nix projects
    nodePackages.node2nix

  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];
}
