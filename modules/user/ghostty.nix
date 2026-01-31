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
      background-opacity = 0.87;
      background-blur = true;
      window-padding-x = 10;
      window-padding-y = 10;
      window-decoration = true;

      # macOS Integration
      macos-option-as-alt = true;

      # Integration
      shell-integration = "detect";

      # Interaction
      mouse-hide-while-typing = true;
      copy-on-select = true;

      # Use Stylix for theming (it should pick up the Tokyo Night Storm automatically)
    };
  };
}
