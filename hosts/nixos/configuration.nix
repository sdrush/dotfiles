{ pkgs, ... }:
{
  imports = [
    ../../modules/linux/system.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "sdrush";
  };

  # Enable zsh for the user
  programs.zsh.enable = true;

  # Enable nix-ld to run unpatched binaries (another requirement for VS Code)
  programs.nix-ld.enable = true;

  networking.hostName = "nixos";

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "@wheel"
        "sdrush"
      ];
    };
  };

  # Define the default user
  users.users.sdrush = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  # Keep the system configuration clean
  system.stateVersion = "24.11";
}
