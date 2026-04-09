{ pkgs, ... }:

{
  # Ghostty: A GPU-accelerated terminal emulator
  # https://github.com/ghostty-org/ghostty
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.ghostty.enable
  programs.ghostty = {
    enable = true;
    # Ghostty has excellent Nix support and will be automatically added to your Applications.
    # We use the package from nixpkgs.
    # On Linux/WSL, we disable the package to avoid heavy GUI dependencies (webkitgtk).
    # On macOS, we install via Homebrew Cask, so we set this to null.
    package = if pkgs.stdenv.isDarwin || pkgs.stdenv.isLinux then null else pkgs.ghostty;

    # If the package is null, we must disable these integrations to avoid Home Manager assertions.
    installBatSyntax = false;
    installVimSyntax = false;
    # systemd integration is only relevant on Linux
    systemd.enable = false;

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
      desktop-notifications = true;

      # Use Stylix for theming (it should pick up the Tokyo Night Storm automatically)
    };
  };
}
