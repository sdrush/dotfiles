# 🛠️ Modern CLI Toolbelt

We've replaced many aging coreutils with modern, faster, and more feature-rich alternatives written in Rust and Go.

## 📋 Core Replacements

| Command | Tool | Why? |
| :--- | :--- | :--- |
| `ls` | **eza** | Icons, git status integration, better colors. |
| `cat` | **bat** | Syntax highlighting, line numbers, git integration. |
| `find` | **fd** | 10x faster, ignores `.gitignore` by default. |
| `grep` | **rg** | (ripgrep) The fastest search tool in existence. |
| `top` | **btop** | GPU support, mouse interaction, beautiful visuals. |
| `watch` | **viddy** | Time-traveling history and diffing. |
| `du` | **dust** | Instant visual breakdown of disk space. |
| `df` | **duf** | User-friendly disk usage table. |
| `env` | **direnv** | Automatically load/unload project environments on `cd`. |

## 🔍 Discovery & Interaction

- **fzf**: The backbone of the environment. Used for fuzzy-finding files, history, and integration with many other tools.
- **navi**: Interactive cheatsheet tool. Press `Ctrl+G` to search through common commands and snippets.
- **tealdeer**: A high-performance implementation of `tldr`. Get practical examples for any command instantly.
- **jq**: The gold standard for JSON processing.

## 📦 Nix-Specific Tools

- **nh (Nix Helper)**: A significantly more pleasant way to run `nixos-rebuild`, `darwin-rebuild`, and Home Manager switches.
- **nix-melt**: TUI for exploring `flake.lock`. Great for understanding dependency updates.
- **nix-index**: Provides `nix-locate`. Ever run a command that isn't installed? Nix-index will tell you exactly which package provides it.
- **vulnix**: Specifically used on NixOS to scan your system for known security advisories.
