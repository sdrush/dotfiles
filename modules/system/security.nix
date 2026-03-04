{
  lib,
  config,
  options,
  ...
}:

{
  options.dotfiles.security.verifiedFetches.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable the experimental verified-fetches Nix feature.";
  };

  config = lib.mkIf (options ? nix) {
    nix.settings.experimental-features = lib.optional config.dotfiles.security.verifiedFetches.enable "verified-fetches";
  };
}
