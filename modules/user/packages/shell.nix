{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Core Utilities
    coreutils
    wget2
    gettext
    yq
    manix

    # Shell Tools
    byobu
    terminal-notifier
    just
    shfmt
    nodePackages.prettier

    # Nix related tools
    nh # Nix Helper
    nix-output-monitor # nom
    comma
    nix-tree
    cachix # adding/managing alternative binary caches hosted by Cachix
    statix # Linter and suggestions for the nix language
    deadnix # Find and remove unused code in .nix source files
    nixfmt # Format nix files
  ];
}
