{ pkgs, ... }:

{
  # Alacritty
  # https://github.com/alacritty/alacritty
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.alacritty.enable
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      window = {
        startup_mode = "Windowed";
        title = "Alacritty";
        dynamic_title = true;
        opacity = 0.87;
      };
      env = {
        TERM = "xterm-256color";
      };
    };
  };
}
