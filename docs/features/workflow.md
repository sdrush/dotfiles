# 🔄 Workflow & Automation

This repository uses **Just** as a unified command runner to simplify complex Nix operations across Darwin, NixOS, and Home Manager.

## 🏗️ The `just rebuild` Command

The core of our workflow. Running `just rebuild` does more than just switch your configuration:

1.  **Detection**: Automatically identifies if you are on macOS, NixOS, or Generic Linux.
2.  **Formatting**: Runs `nix fmt` to ensure all your changes are pristine.
3.  **Linting**: Runs `statix` and `deadnix` to catch common Nix anti-patterns and unused variables.
4.  **Application**: Applies the new configuration using the best available tool (`nh`, `darwin-rebuild`, or `home-manager`).

## 📋 Common Recipes

| Recipe               | Description                                                 |
| :------------------- | :---------------------------------------------------------- |
| `just rebuild`       | Format, lint, and apply the latest changes.                 |
| `just update`        | Update all flake inputs to their latest versions.           |
| `just gc`            | Garbage collect old Nix generations (keeps last 7 days).    |
| `just security-scan` | (NixOS only) Scan your system for known vulnerabilities.    |
| `just diff`          | Show the exact changes (packages/versions) before applying. |
| `just history`       | Show the history of your machine's generations.             |
| `just rollback`      | Instantly revert to the previous working generation.        |
| `just secrets`       | Edit encrypted SOPS secrets using your system editor.       |

## 🛡️ Automated Quality Controls

- **Pre-commit**: We use `git-hooks.nix` (if available in the environment) to prevent commits that don't pass linting.
- **Flake Check**: Running `just check` performs a full `nix flake check`, ensuring your entire configuration is valid and evaluatable.
- **Evaluation Cache**: Our CI/CD pipeline ensures that the `FLAKE_CHECK` always passes before merging.
