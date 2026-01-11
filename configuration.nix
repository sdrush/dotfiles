{
  pkgs,
  lib,
  user,
  ...
}:
{
  imports = [
    ./modules/system/homebrew.nix
  ];
  # Nix configuration -----------------------------------------------------------------------------
  system = {
    stateVersion = 5;

    # Keyboard
    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToEscape = true;
  };
  nix = {
    optimise.automatic = true;
    settings = {
      substituters = [
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [
        "@admin"
      ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    ''
    + lib.optionalString (pkgs.stdenv.hostPlatform.system == "x86_64-darwin") ''
      extra-platforms = x86_64-darwin x86_64-linux
    '';

    # Nix automatic garbage collection
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      }; # Every Sunday at 2 AM
      options = "--delete-older-than 30d";
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [ ];
  environment.variables = { };

  # User(s)
  users.users."${user}" = {
    name = "${user}";
    home = "/Users/${user}";
  };
  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
  ];

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

}
