{ pkgs, ... }:

{
  # Ghostty: A GPU-accelerated terminal emulator
  # https://github.com/ghostty-org/ghostty
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.ghostty.enable
  programs.ghostty = {
    enable = true;
    # Ghostty has excellent Nix support and will be automatically added to your Applications.
    # We use the package from nixpkgs.
    # On macOS, we install the binary via Homebrew Cask because the Nixpkgs
    # version is currently unsupported on aarch64-darwin.
    package = null;

    settings = {
      # Performance & Appearance
      window-opacity = 0.87;
      window-decoration = true; # Use native window decorations on macOS

      # Integration
      shell-integration = "detect";

      # Use Stylix for theming (it should pick up the Tokyo Night Storm automatically)
    };
  };
}
