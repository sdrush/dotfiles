{ pkgs, lib, ... }:

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
    ./modules/user/tmux.nix
    ./modules/user/zsh.nix
    ./modules/user/abbr.nix
  ];
  programs.home-manager.enable = true;
  home = {
    sessionPath = [
      "$HOME/.rd/bin"
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      "/opt/homebrew/bin"
      "/usr/local/bin"
    ];

    packages =
      with pkgs;
      lib.optionals pkgs.stdenv.isLinux [
        vim
        git
        curl
        wget
      ];

    stateVersion = "24.11";
  };

  # Disable dconf on Linux to avoid DBus issues in WSL
  dconf.settings = lib.mkIf pkgs.stdenv.isLinux (lib.mkForce { });

  # Disable user unit reloading on Linux to avoid DBus activation errors in headless WSL
  systemd.user.startServices = lib.mkIf pkgs.stdenv.isLinux false;

  # Man pages
  manual.manpages.enable = true;
}
