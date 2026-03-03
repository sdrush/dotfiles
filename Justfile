# Default task: list all recipes
default:
    @just --list

## System Detection
os := `uname -s`

# Rebuild and switch the system configuration
rebuild: format lint
    @if [ "{{os}}" = "Darwin" ]; then \
        if command -v nh >/dev/null; then \
            echo "Updating Darwin system with nh..."; \
            nh darwin switch .; \
        else \
            echo "Updating Darwin system with darwin-rebuild..."; \
            darwin-rebuild switch --flake .; \
        fi \
    elif [ -e /etc/NIXOS ]; then \
        echo "Updating NixOS system..."; \
        sudo nixos-rebuild switch --flake .#nixos; \
    else \
        if command -v nh >/dev/null; then \
            echo "Updating Home Manager configuration with nh..."; \
            nh home switch .; \
        else \
            echo "Updating Home Manager configuration..."; \
            home-manager switch --flake .; \
        fi \
    fi

# Update all flake inputs to their latest versions
update:
    nix flake update

# Check for Nix syntax and common issues
lint:
    statix check .
    deadnix .

# Format all Nix files in the repository
format:
    nix fmt

# Run flake checks to ensure everything is valid
check:
    nix flake check

# Garbage collect and delete old generations using nh (keeps last 7 days)
gc:
    sudo nh clean all --keep 7

# Build the latest flake without applying it
build:
    nom build .

# Search for a package in nixpkgs using nh
search query:
    nh search {{query}}

# Show differences between the current system and the new flake
diff:
    @if ! command -v nvd >/dev/null; then echo "nvd not found. Install it for diff support."; exit 1; fi
    @if [ "{{os}}" = "Darwin" ]; then \
        nvd diff /run/current-system $(nix build --no-link --print-out-paths .); \
    else \
        TARGET_PROFILE=$(readlink -f ~/.local/state/nix/profiles/home-manager || echo ""); \
        if [ -z "$TARGET_PROFILE" ]; then echo "Home Manager profile not found."; exit 1; fi; \
        nvd diff $$TARGET_PROFILE $(nix build --no-link --print-out-paths .); \
    fi

# Update everything: nix flake, homebrew, and local dotfiles
update-all:
    topgrade

# Show the history of Nix generations
history:
    @if [ "{{os}}" = "Darwin" ]; then \
        nix-env --list-generations --profile /nix/var/nix/profiles/system; \
    else \
        nix-env --list-generations --profile ~/.local/state/nix/profiles/home-manager; \
    fi

# Quickly rollback to the previous generation
rollback:
    @if [ "{{os}}" = "Darwin" ]; then \
        sudo /nix/var/nix/profiles/system/bin/switch-to-configuration rollback; \
    else \
        home-manager generations | head -n 2 | tail -n 1 | awk '{print $NF}' | xargs -I {} sh -c "{}/activate"; \
    fi

# Explore the dependency graph of the current system (interactive)
explore:
    @if [ "{{os}}" = "Darwin" ]; then \
        nix-tree /run/current-system; \
    else \
        nix-tree $(readlink -f ~/.local/state/nix/profiles/home-manager); \
    fi

# Run a full store optimization to save space
optimize:
    nix-store --optimize

# Edit repository secrets using SOPS
secrets:
    sops secrets.yaml

# List all deep-dive documentation guides
docs:
    @ls -1 docs/*.md | xargs -n 1 basename