# 💻 Development Environment

This repository uses a **Modular Persona** system to keep the base OS "thin" while providing powerful, reproducible development environments.

## 🎭 Modular Dev Personas

Located in `modules/user/dev/`, these modules provide the essential toolchains for specific development roles.

### Available Personas

| Persona    | Module       | Core Tools                                         |
| :--------- | :----------- | :------------------------------------------------- |
| **Cloud**  | `cloud.nix`  | GCloud (with GKE auth), Kubectl, Helm, Stern, K9s. |
| **Go**     | `go.nix`     | Go toolchain, golangci-lint, delve.                |
| **Node**   | `node.nix`   | Node.js 22, NPM, Yarn, PNPM, Typescript.           |
| **Python** | `python.nix` | Python 3.12, Poetry, UV, and data libraries.       |

## 🚀 Direnv & Nix-Direnv

We use **[Direnv](https://direnv.net/)** combined with **[nix-direnv](https://github.com/nix-community/nix-direnv)** to provide a seamless, fully automated development experience.

- **Automatic Activation**: Simply `cd` into a project directory, and your entire development environment (compilers, libraries, tools) is instantly loaded into your shell.
- **Persistence**: Unlike standard `nix-shell`, `nix-direnv` caches the environment. This means subsequent entries into the directory are near-instant.
- **No Manual Steps**: Forget running `nix-shell` or `devenv up`. Once you've run `direnv allow` once, it just works.
- **Visual Feedback**: Your Starship prompt will automatically indicate when a Nix environment is active.

## 📦 Devenv Integration

### 📖 How to Use in Your Project

Add a persona to your project-local `devenv.nix`:

```nix
{ pkgs, ... }: {
  imports = [
    # Adjust path to your local dotfiles checkout
    ~/.dotfiles/modules/user/dev/cloud.nix
    ~/.dotfiles/modules/user/dev/go.nix
  ];
}
```

Then run `direnv allow` to have the environment activate automatically when you `cd` into the directory.

## 🛠️ Secret Management

We use **[sops-nix](https://github.com/Mic92/sops-nix)** for secure, encrypted secret management.

- **Hardware-backed**: Integrates with Yubikeys (PIV/OpenPGP).
- **Format**: Secrets are stored in `secrets.yaml` and decrypted on-the-fly into the Nix store.
- **Workflow**: Use `just secrets` to edit your configuration safely.

_See [Documentation: Secret Management](../secrets.md) for a deep dive._
