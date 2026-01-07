{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/aliases.nix
    ./modules/alacritty.nix
    ./modules/git.nix
    ./modules/navi.nix
    ./modules/packages.nix
    ./modules/programs.nix
    ./modules/starship.nix
    ./modules/tmux.nix
    ./modules/zsh.nix
  ];
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  # Man pages
  manual.manpages.enable = true;

  home.sessionPath = [
    "/~.rd/bin"
  ];
}
