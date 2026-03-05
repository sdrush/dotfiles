# Shannon's Nix Dotfiles 🏎️✨

A unified, high-performance configuration for **macOS (Darwin)**, **NixOS**, and **Generic Linux (Fedora/WSL)**. Built with **nix-darwin**, **home-manager**, and **flakes**.

## 🚀 Unified Performance

These dotfiles provide a consistent, lightning-fast experience across every machine you touch.

- **Shell Reactivity**: Zsh with asynchronous loading (`zsh-defer`) and Starship prompt.
- **Cross-Platform**: One flake to rule them all—Darwin, NixOS, and Home Manager are all first-class citizens.
- **Modern Tooling**: Rust-powered CLI replacements (`eza`, `bat`, `fzf`, `rg`) for everything.
- **Unified Theming**: System-wide visual harmony via **Stylix** (Tokyo Night Storm).

---

## 🧭 Documentation Hub

For deep-dive guides on the specific features and workflows, visit the **[Documentation Hub](docs/README.md)**:

### 🧩 Core Features

- [**Platforms & OS Support**](docs/features/platforms.md): Darwin, NixOS, and WSL integration.
- [**Shell & Commands**](docs/features/shell.md): Zsh performance, abbreviations, and Ghostty.
- [**Modern CLI Toolbelt**](docs/features/cli-tools.md): Catalog of modern coreutil replacements.
- [**Development Personas**](docs/features/development.md): Reproducible environments for Go, Python, Node, and Cloud.
- [**Editor Configurations**](docs/features/editors.md): Nixvim and VSCode setup.
- [**Workflow & Automation**](docs/features/workflow.md): Using the `Justfile` and auto-rebuilds.
- [**PR Workflow Guide**](docs/features/pr-workflow.md): Safe configuration updates via Pull Requests and code reviews.
- [**Theming & Visuals**](docs/features/theming.md): Stylix and terminal aesthetics.

### 🧠 Knowledge Base

- [**Secret Management**](docs/secrets.md): Encrypted configs with SOPS and Yubikeys.
- [**Bootstrapping Guide**](docs/bootstrapping.md): Setting up a new machine from scratch.

---

## 🏗️ Quick Start

```bash
# Rebuild and apply the system configuration (Detects OS automatically)
just rebuild

# Clean up old Nix generations
just gc

# Update all flake inputs
just update

# Run a security scan (NixOS only)
just security-scan
```
