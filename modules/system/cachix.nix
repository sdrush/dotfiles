{
  lib,
  options,
  ...
}:

{
  config = lib.mkIf (options ? nix) {
    nix.settings = {
      extra-substituters = [
        "https://sdrush.cachix.org"
      ];
      extra-trusted-public-keys = [
        "sdrush.cachix.org-1:g7fLFRwyj6OGcG+qz9PcsOHt1hlwQGE9aBn//xbCm0M="
      ];
    };
  };
}
