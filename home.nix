{ ... }:

{
  imports = [
    ./modules/user/packages
    ./modules/user/aliases.nix
    ./modules/user/alacritty.nix
    ./modules/user/git.nix
    ./modules/user/navi.nix
    ./modules/user/neovim.nix
    ./modules/user/programs.nix
    ./modules/user/secrets.nix
    ./modules/user/starship.nix
    ./modules/user/tmux.nix
    ./modules/user/zsh.nix
  ];
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  # Man pages
  manual.manpages.enable = true;

  home.sessionPath = [
    "/~.rd/bin"
  ];
}
