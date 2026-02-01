# Default task: list all recipes
default:
    @just --list
# Rebuild and switch the Darwin system using Nix Helper (nh)
rebuild: format lint
    nh darwin switch .
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
    nvd diff /run/current-system $(nix build --no-link --print-out-paths .)
# Update everything: nix flake, homebrew, and local dotfiles
update-all:
    topgrade
# Show the history of Nix generations
history:
    nix-env --list-generations --profile /nix/var/nix/profiles/system
# Quickly rollback to the previous generation
rollback:
    sudo /nix/var/nix/profiles/system/bin/switch-to-configuration rollback
# Explore the dependency graph of the current system (interactive)
explore:
    nix-tree /run/current-system
# Run a full store optimization to save space
optimize:
    nix-store --optimize

# Edit repository secrets using SOPS
secrets:
    sops secrets.yaml

# List all deep-dive documentation guides
docs:
    @ls -1 docs/*.md | xargs -n 1 basename