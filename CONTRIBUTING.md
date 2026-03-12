# Contributing to Dotfiles

Thank you for contributing! To maintain a high-quality and stable configuration, we follow a structured development workflow.

## Development Workflow

1.  **Create a Branch**: Always work on a feature branch, even for small changes.
    ```bash
    git checkout -b my-feature-name
    ```
2.  **Make Changes**: Implement your changes.
3.  **Verify Locally**: Use `just` to ensure your changes are valid and don't break existing configurations.
    - `just format`: Format all Nix files.
    - `just lint`: Check for common issues and unused variables.
    - `just check`: Run full flake checks.
    - `just rebuild`: Apply the configuration to your local system (optional but recommended).
4.  **Commit**: Use descriptive commit messages.
5.  **Push and Open a PR**: Push your branch to GitHub and open a Pull Request against `main`.
6.  **CI Checks**: Ensure all GitHub Actions pass.
7.  **Merge**: Once CI passes and you've reviewed the diff, merge your PR.

## Branch Protection Rules

To prevent accidental breakage, the following rules are enforced on the `main` branch:

- **Require a Pull Request before merging**: No direct pushes to `main`.
- **Require Status Checks to pass**: `Check` and `Nix Flake Diff` must pass before merging.

## Local Development Tools

- **`just`**: The command runner for all common tasks.
- **`direnv`**: Automatically loads the development shell (`nix develop`) when you enter the directory.
- **`pre-commit`**: Automatically runs linting and security checks before every commit.
