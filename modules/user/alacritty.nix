{ pkgs, ... }:

{
  # Alacritty
  # https://github.com/alacritty/alacritty
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.alacritty.enable
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
  };

  home.file = {
    ".config/alacritty/alacritty.yml".source = ./alacritty.yml;
  };
}