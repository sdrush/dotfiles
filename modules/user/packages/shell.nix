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
    terminal-notifier
    just
    shfmt
    nodePackages.prettier

    # Modern CLI Alternatives
    duf # Disk Usage Free (df replacement)
    dust # Disk Usage (du replacement)
    procs # Process viewer (ps replacement)
    fastfetch # System info (neofetch alternative)
    sd # Intuitive find & replace (sed alternative)
    choose # Human-friendly cut/awk alternative
    doggo # Modern DNS client (dig alternative)
    gping # Ping with a graph
    nvd # Nix version diff
    viddy # Modern watch replacement

    # Nix related tools
    nix-output-monitor # nom
    nix-melt # Flake input explorer
    devenv
    tenv # Terraform/OpenTofu version manager
    comma
    nix-tree
    cachix # adding/managing alternative binary caches hosted by Cachix
    statix # Linter and suggestions for the nix language
    deadnix # Find and remove unused code in .nix source files
    nixfmt # Format nix files
  ];
}
