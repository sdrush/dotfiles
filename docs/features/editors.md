# 📝 Editor Configurations

We provide deeply integrated configurations for both **Nixvim (Neovim)** and **Visual Studio Code**.

## 🚀 Nixvim (Neovim)

Our Neovim configuration is built entirely in Nix via **[Nixvim](https://github.com/nix-community/nixvim)**.

- **Unified Interface**: Includes a statusline (`lualine`), project diagnostics (`trouble`), and a file tree (`neo-tree`).
- **LSP & Autocomplete**: Pre-configured for Nix (`nixd`), Go (`gopls`), Python (`pyright`), and Lua (`lua_ls`).
- **Fuzzy Finding**: Powered by **Telescope** for files, buffers, and grep.
- **Performance**: Lazy-loading and optimized plugins ensure instant startup.
- **Theming**: Automatically themed via Stylix to match the system.

### Key Keybindings:
- `<leader>ff`: Find Files
- `<leader>fg`: Live Grep
- `<leader>e`: Toggle Explorer
- `<leader>xx`: Project Diagnostics

## 💻 Visual Studio Code

We use the Nix-managed version of VSCode to ensure all extensions and settings are reproducible across machines.

- **Cross-Platform**: Configured similarly on macOS and Linux.
- **Antigravity (Remote) Friendly**: On NixOS and WSL, we explicitly configure `nix-ld` so that the VS Code server and all its extensions work perfectly despite being unpatched binaries.
- **Stylix Support**: Your VS Code theme will automatically update when you change your system-wide Stylix theme.
