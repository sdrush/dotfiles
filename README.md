# Shannon's Darwin Dotfiles 🏎️✨

Personal dotfiles for macOS management using **nix-darwin**, **home-manager**, and **flakes**.

## 🚀 Performance Architecture

These dotfiles are tuned for maximum responsiveness and a "Goldilocks" balance of speed and functionality.

### Shell Optimization

- **Starship Prompt**: Tuned to avoid interactive sub-shell overhead, saving significant CPU cycles.
- **Lazy-Loading**: Heavy plugins (brew, gcloud, kubectl, direnv) are deferred via `zsh-defer`, allowing the prompt to appear instantly.
- **Completion System**: Bypasses slow `compaudit` checks and uses persistent dump files for near-instant initialization.

### Automated Code Quality 🛡️

- **Integrated Linting**: `just rebuild` automatically runs `statix` and `deadnix`.
- **Pre-commit Hooks**: Leveraging `git-hooks.nix` to block messy commits and maintain repo health.
- **Auto-Formatting**: Uses `nix fmt` (powered by `nixfmt`) to keep all Nix code pristine.

## 🎭 Modular Dev Personas

We use a modular system to keep the base OS "thin" while providing powerful, reproducible development environments via **devenv**.

### Available Personas

Located in `modules/user/dev/`:

- **Cloud (`cloud.nix`)**: GCloud (with GKE auth), Kubectl, Helm, Stern, K9s.
- **Go (`go.nix`)**: Go toolchain, golangci-lint, delve.
- **Node (`node.nix`)**: Node.js 22, NPM, Yarn, PNPM, Typescript.
- **Python (`python.nix`)**: Python 3.12, Poetry, UV, and common data libraries.

### Usage in a Project

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

Then run `direnv allow` to have the environment activate automatically on `cd`.

## 🛠️ Modern Tooling

We've replaced many legacy coreutils with faster, modern alternatives:

- **viddy**: Time-traveling `watch` replacement.
- **nix-melt**: TUI for exploring `flake.lock` dependencies.
- **duf / dust**: Modern disk usage viewers.
- **procs**: Modern process viewer.
- **Ghostty**: High-performance, GPU-accelerated terminal.

## 🧠 Knowledge Base

For deep-dive guides on critical workflows, check out the **[Documentation Hub](docs/README.md)**:

- [Secret Management Guide](docs/secrets.md)
- [Machine Bootstrapping Guide](docs/bootstrapping.md)

## 🏗️ Workflow

```bash
# Rebuild and apply the system configuration
just rebuild

# Clean up old Nix generations
just gc

# Format and Lint all files
just format
just lint
```
