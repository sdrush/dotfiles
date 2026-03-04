# 💻 Platform Support

This repository is a unified, cross-platform configuration for **macOS (Darwin)**, **NixOS**, and **Generic Linux (Home Manager)**.

## 🍎 macOS (Darwin)

Powered by `nix-darwin`, this is the primary development environment.

- **System Management**: Configures macOS defaults, power management, and dock settings via `modules/darwin/macos.nix`.
- **Homebrew Integration**: Automatically manages casks and Mac App Store (MAS) apps via `modules/darwin/homebrew.nix`.
- **Performance**: Optimized for Apple Silicon (`aarch64-darwin`) with specific adjustments for Ghostty and other GPU-accelerated tools.
- **Hardware Profile**: The `typhon` host defines the specific settings for a high-performance M-series Mac.

## ❄️ NixOS

A pure NixOS configuration, optimized for both bare-metal and WSL environments.

- **WSL Optimization**: Uses `nixos-wsl` for a seamless Windows experience.
- **VS Code/Antigravity**: Specifically configured with `nix-ld` and WSL workarounds to ensure remote development works out of the box.
- **Security**: Includes `vulnix` integration for automated security audits of the NixOS closure.
- **Hardware Profile**: The `nixos` host provides a stable, reproducible base for Linux development.

## 🐧 Generic Linux (Fedora/WSL)

For environments where Nix is installed as a standalone package manager.

- **Home Manager**: Manages the entire user environment (`$HOME`) including Zsh, specialized CLI tools, and dev personas.
- **Nix Helper (`nh`)**: Integrated for easier rebuilds and generation management even without full NixOS.
- **Compatibility**: Tested extensively on **Fedora 41** under WSL.
- **Setup**: Requires the user to be in `trusted-users` to leverage binary caches (Cachix).

## 🔀 Cross-Platform Features

- **Stylix**: Unified theming across all platforms (Tokyo Night Storm by default).
- **Home Manager**: 95% of user configuration is shared exactly across Darwin and Linux.
- **Justfile**: A unified entry point for all platforms. `just rebuild` automatically detects your OS and does the right thing.
