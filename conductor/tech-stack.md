# Technology Stack

## Core Technologies
- **Nix:** The primary language and functional package manager used for the entire system and user configuration.
- **nix-darwin:** Provides a Nix-based declarative configuration for macOS system settings.
- **home-manager:** Manages user-specific environments, dotfiles, and application configurations across both macOS and Linux.

## Configuration & Theming
- **NixVim:** A Nix-based configuration system for Neovim, ensuring the editor setup is reproducible.
- **Stylix:** A system-wide styling tool that automatically applies a unified color scheme to various applications.
- **sops-nix:** Integrates SOPS with Nix for managing encrypted secrets.

## Dependency Management
- **Poetry:** Used for managing Python environments and dependencies within the project.
- **Homebrew:** Employed as a secondary manager for macOS GUI applications and packages not available via Nix.

## Development Workflow
- **treefmt-nix:** Provides a unified interface for code formatting across different languages in the project.
- **git-hooks.nix:** Manages pre-commit hooks to ensure code quality and consistency.
