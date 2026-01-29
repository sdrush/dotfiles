# Product Guidelines

## Documentation & Communication
- **Tone and Voice:** Technical and concise. Documentation and commit messages should be direct, clear, and focused on the technical implementation.
- **Commit Messages:** Should follow a clear pattern (e.g., `feature(zsh): add aliases`) to maintain a clean history.

## Visual Identity
- **Consistent Theming:** Leverage Stylix to maintain a unified color scheme and aesthetic across all supported applications, including the terminal, editor, and system UI.
- **Typography:** Mandatory use of Nerd Fonts (e.g., Fira Code) across all environments to ensure proper icon rendering and font ligatures.

## Architectural Patterns
- **Functional Grouping:** Nix modules should be organized by their functional role (e.g., system-wide vs. user-specific) to maintain a modular and scalable codebase.
- **Declarative Configuration:** Prioritize declarative Nix configurations over imperative setup steps whenever possible.

## Dependency Management
- **Pragmatic Hybrid Approach:** Use Nix for system configuration, core CLI tools, and reproducible environments. Utilize Homebrew specifically for managing macOS-exclusive GUI applications that are not easily handled via Nix.

## Security & Secrets
- **Encrypted Storage:** All sensitive data (API keys, personal configurations) must be encrypted within the repository using SOPS to ensure security while maintaining a version-controlled configuration.
