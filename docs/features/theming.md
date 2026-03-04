# 🎨 Theming & Visuals

We believe a development environment should be as beautiful as it is functional. We use **Stylix** to provide a unified, system-wide aesthetic.

## 🌈 Stylix Integration

**[Stylix](https://github.com/danth/stylix)** is the backbone of our visual identity. It coordinates colors, fonts, and backgrounds across dozens of different tools.

- **Default Theme**: **Tokyo Night Storm** (a dark, balanced, high-contrast palette).
- **Automatic Theming**: Once you set your Stylish theme, it is automatically applied to:
    - Zsh & Starship
    - Ghostty & Terminal emulators
    - Neovim (Nixvim)
    - VS Code
    - Bat, Btop, and other CLI TUIs
    - System UI (macOS elements and GTK on Linux)

## ⌨️ Ghostty Terminal

Our primary terminal, **Ghostty**, is configured for a premium, high-performance look:
- **Glassmorphism**: 87% background opacity with active blur enabled.
- **Window Padding**: 10px padding for better visual breathing room.
- **Stylix Support**: Automatically inherits the system color palette and font settings.

## 🔤 Typography

We use modern, high-legibility fonts across the entire system.
- **Mono**: High-quality coding fonts defined in `modules/darwin/fonts.nix` and `modules/user/stylix.nix`.
- **Icons**: Full support for Nerd Fonts (icons in `ls`, `yazi`, and Neovim).
