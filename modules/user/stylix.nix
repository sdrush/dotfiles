{ pkgs, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";

    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/zhifree/wallpapers/main/minimalistic/tokyo-night.png";
      sha256 = "sha256-RndK3t7yV2VshwF+3XUeOn1M9X9S5B9m6x2Z4vXy3X4=";
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Mono";
      };
    };

    opacity = {
      terminal = 0.87;
    };
  };
}
