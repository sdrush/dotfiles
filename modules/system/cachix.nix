{
  lib,
  options,
  ...
}:

{
  config = lib.mkIf (options ? nix) {
    nix.settings = {
      substituters = [
        "https://sdrush.cachix.org"
      ];
      trusted-public-keys = [
        "sdrush.cachix.org-1:g7fLFRwyj6OGcG+qz9PcsOHt1hlwQGE9aBn//xbCm0M="
      ];
    };
  };
}
