{ pkgs, lib, user,... }:
{
  imports = [
    ./modules/homebrew.nix
  ];
  # Nix configuration -----------------------------------------------------------------------------
  system.stateVersion = 5;
  nix.settings.substituters = [
    "https://cache.nixos.org/"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
  nix.settings.trusted-users = [
    "@admin"
  ];

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  ''
  + lib.optionalString (pkgs.stdenv.hostPlatform.system == "x86_64-darwin") ''
    extra-platforms = x86_64-darwin x86_64-linux
  '';

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [ ];
  environment.variables = { };
  programs.nix-index.enable = true;

  # User(s)
  users.users."${user}" = {
    name = "${user}";
    home = "/Users/${user}";
  };
  # Fonts
  fonts.packages = with pkgs; [
    (pkgs.nerd-fonts.fira-code)
    (pkgs.nerd-fonts.meslo-lg)
  ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

}
