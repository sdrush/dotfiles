# 🐚 Shell & Command Line

Our shell environment is tuned for **instant reactivity** and **high productivity**. We use Zsh with a focus on eliminating the latency that usually plagues complex Nix configurations.

## ⚡ Performance Architecture

- **Zsh-Defer**: Heavy plugins (GCloud, Kubectl, Direnv) are loaded asynchronously. Your prompt appears instantly, even if background tools are still initializing.
- **Completion Optimization**: We skip the slow `compaudit` check on startup and use a persistent `.zcompdump`.
- **Starship Prompt**: Configured to be lightweight and avoid expensive sub-shell calls during interactive use.

## ⌨️ Zsh Abbreviations (`zsh-abbr`)

Instead of standard aliases, we use **Abbreviations**. As you type, the short command expands into the full version. 

*Benefit: You get the speed of short commands, but your history and screen show the clear, full command.*

### Notable Abbreviations:
- **Git**: `gst` (status), `ga` (add), `gc` (commit), `gp` (push), `gl` (pull).
- **Terraform**: `tfp` (plan), `tfa` (apply), `tfi` (init).
- **Workflow**: `reborn` (just rebuild), `dotcfg` (edit dotfiles).
- **Productivity**: `myip` (public IP), `wttr` (weather).

*See `modules/user/abbr.nix` for the full list.*

## 📂 Navigation & History

- **Zoxide (`cd` replacement)**: Remapped to `cd`. It learns your habits and lets you jump to directories with `cd project` instead of full paths.
- **Atuin (Searchable History)**: Replaces `Ctrl+R` with a beautiful, fast, and searchable history TUI.
- **Yazi (`yy`)**: A blazing fast terminal file manager for when `cd` isn't enough.

## 🎨 Terminal: Ghostty

We use **Ghostty**, a GPU-accelerated terminal.
- **Stylix Support**: Automatically themed to match your system.
- **Blur & Opacity**: Configured for a premium "Glassmorphism" look.
- **macOS Native**: Uses local Homebrew on Darwin for maximum stability while maintaining Nix-based configuration.
