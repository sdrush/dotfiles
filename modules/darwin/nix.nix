{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  nix = {
    # Pin the registry to the same version as our flake
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

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
      experimental-features = [
        "nix-command"
        "flakes"
      ]
      ++ lib.optional (pkgs.stdenv.hostPlatform.system == "x86_64-darwin") "extra-platforms";
    }
    // lib.optionalAttrs (pkgs.stdenv.hostPlatform.system == "x86_64-darwin") {
      extra-platforms = "x86_64-darwin x86_64-linux";
    };
  };
}
