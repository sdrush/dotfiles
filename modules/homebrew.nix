{ config, lib, ... }:

{
  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.lockfiles = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
    "microsoft/git"
    "nrlquaker/createzap"
  ];

  # Prefer installing application from the Mac App Store
  #
  # Commented apps suffer continual update issue:
  # https://github.com/malob/nixpkgs/issues/9
  homebrew.masApps = {
    # BitWarden = 1352778147;
    # "CopyClip - Clipboard History" = 595191960;
    # "HP Smart" = 1474276998;
    iMovie = 408981434;
    # Keynote = 409183694;
    # "Microsoft Remote Desktop" = 1295203466;
    MindNode = 1289197285;
    Numbers = 409203825;
    OneNote = 784801555;
    Pages = 409201541;
    "Save to Raindrop.io" = 1549370672;
    Securid = 318038618;
    Slack = 803453959;
  };

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
    "amethyst" # tiling window manager a la xmonad
    "anki" # flashcards
    "authy" # multiplatform token generator
    # "arq" # cloud backups
    # "element" # zerotier replacement
    "discord"
    "dropbox"
    "github"
    "git-credential-manager-core"
    # "google-chrome" need to uninstall and reinstall via brew
    "google-drive"
    "gpg-suite"
    # "hammerspoon"# Lua Automation engine for macos
    "insomnia" # api client
    "iterm2"
    "keybase"
    "lens" # kubernetes tool
    "meld" # file/folder comparison tool
    "numi" # calculator
    # "obsidian" # open source knowledge base -> migrated to nixpkg version
    "postman"
    "rancher"
    "raindropio" # bookmark manager
    "raycast" # mac launcher
    "secretive" # store ssh keys in the secure enclave
    "securid"
    "signal"
    "skype"
    "spotify"
    "steam"
    "ubar"
    # "superhuman" # cool looking gmail client
    "visual-studio-code"
    "vnc-viewer"
    "zotero"
    # "yubico-yubikey-manager"
    # "yubico-yubikey-personalization-gui"
  ];

  # Configuration related to casks
  # environment.variables.SSH_AUTH_SOCK = mkIfCaskPresent "1password-cli"
  #   "/Users/${config.users.primaryUser.username}/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";

  # For cli packages that aren't currently available for macOS in `nixpkgs`.Packages should be
  # installed in `../home/default.nix` whenever possible.
  homebrew.brews = [
  ];
}
