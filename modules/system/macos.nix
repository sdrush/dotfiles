{ ... }:

{
  system.defaults = {
    # Finder settings
    finder = {
      AppleShowAllExtensions = true; # Show all file extensions
      AppleShowAllFiles = true;      # Show hidden files
      FXEnableExtensionChangeWarning = false; # Disable warning when changing extension
      _FXShowPosixPathInTitle = true; # Show path in Finder title
      ShowPathbar = true;            # Show path bar at bottom
      ShowStatusBar = true;           # Show status bar
    };

    # NSGlobalDomain settings (General system-wide)
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark"; # Enforce dark mode
      
      # Fast keyboard repeat
      InitialKeyRepeat = 15; # Low delay before repeating starts
      KeyRepeat = 2;        # Fast repeat rate
      
      "com.apple.mouse.tapBehavior" = 1; # Enable tap-to-click
    };

    # Trackpad settings
    trackpad = {
      Clicking = true;            # Enable tap to click
      TrackpadRightClick = true;  # Enable two-finger right click
    };

    # Custom preferences (e.g., Screencapture location)
    CustomUserPreferences = {
      "com.apple.screencapture" = {
        location = "~/Desktop/Screenshots";
        type = "png";
      };
    };
  };
}