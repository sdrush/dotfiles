{
  pkgs,
  lib,
  ...
}:
{
  nixpkgs.hostPlatform = "x86_64-linux";

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };

  # Basic systemPackages for system-manager
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
  ];

  # Example: Manage a file via system-manager
  # system-manager.etc.file."nix/nix.custom.conf".text = "max-jobs = auto\n";
}
