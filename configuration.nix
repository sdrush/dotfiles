{
  pkgs,
  lib,
  user,
  inputs,
  ...
}:
{
  imports = [
    ./modules/system/homebrew.nix
    ./modules/system/macos.nix
    ./modules/system/nix.nix
    ./modules/system/users.nix
    ./modules/system/fonts.nix
  ];
  # Nix configuration -----------------------------------------------------------------------------
  system = {
    stateVersion = 5;

    # Keyboard
    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToEscape = true;
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [ ];
  environment.variables = { };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;
}
