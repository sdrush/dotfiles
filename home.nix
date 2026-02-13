{ ... }:

{
  imports = [
    ./modules/user/packages
    ./modules/user/aliases.nix
    ./modules/user/ghostty.nix
    ./modules/user/git.nix
    ./modules/user/navi.nix
    ./modules/user/nixvim.nix
    ./modules/user/programs.nix
    ./modules/user/secrets.nix
    ./modules/user/starship.nix
    ./modules/user/stylix.nix
    ./modules/user/tmux.nix
    ./modules/user/zsh.nix
    ./modules/user/abbr.nix
  ];
  programs.home-manager.enable = true;
  home.sessionPath = [
    "/opt/homebrew/bin"
    "/usr/local/bin"
    "$HOME/.rd/bin"
  ];
  home.stateVersion = "24.11";

  # Man pages
  manual.manpages.enable = true;
}
