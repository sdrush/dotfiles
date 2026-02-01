# Bootstrapping a New Machine 🏗️✨

Follow these steps to replicate this exact environment on a fresh macOS installation.

## 1. Prerequisites

- **Install Xcode Command Line Tools**:
  ```zsh
  xcode-select --install
  ```
- **Install Homebrew**:
  ```zsh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

## 2. Install Nix

We recommend the [Determinate Systems Nix Installer](https://github.com/DeterminateSystems/nix-installer):

```zsh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## 3. Clone & Prepare

```zsh
git clone https://github.com/sdrush/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

## 4. Restore Secrets

> [!IMPORTANT]
> You MUST have your `age` private key to proceed if you want secrets.

1. Create the directory: `mkdir -p ~/.config/sops/age/`
2. Restore your `keys.txt` from your password manager into that directory.

## 5. First Build

- **Install Just**: `brew install just`
- **Build and Switch**:
  ```zsh
  just rebuild
  ```
  > [!NOTE]
  > The first run will take some time as it downloads all toolchains and builds the system configuration.

## 6. Post-Installation

1. **Shell**: Restart your terminal to load the new Zsh configuration.
2. **Ghostty**: Ensure Ghostty is the default terminal.
3. **SSO/Cloud**: Run `gcloud auth login` and `vault login` etc. as needed in your dev shells.
