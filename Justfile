# Default task: list all recipes
default:
    @just --list
# Rebuild and switch the Darwin system using Nix Helper (nh)
rebuild:
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
    nixfmt **/*.nix
# Run flake checks to ensure everything is valid
check:
    nix flake check
# Garbage collect and delete old generations using nh (keeps last 7 days)
gc:
    nh clean all --keep 7
# Build the latest flake without applying it
build:
    nom build .