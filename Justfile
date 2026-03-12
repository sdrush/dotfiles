# Run our global detections for os/hostname/etc.
os := `uname -s`
host := `hostname -s`
user := `id -un`
is_nixos := `if [ -e /etc/NIXOS ]; then echo "true"; else echo "false"; fi`

# Define common paths and targets
target := if os == "Darwin" {
    ".#darwinConfigurations." + host + ".system"
} else if is_nixos == "true" {
    ".#nixosConfigurations." + host + ".config.system.build.toplevel"
} else {
    if user == "runner" {
        ".#systemConfigs.default"
    } else {
        ".#homeConfigurations.\"" + user + "@" + host + "\".activationPackage"
    }
}

current_system := if os == "Darwin" {
    "/run/current-system"
} else if is_nixos == "true" {
    "/run/current-system"
} else {
    "~/.local/state/nix/profiles/home-manager"
}

# Default task: list all recipes
default:
    @just --list

# Rebuild and switch the system configuration
rebuild: format lint check-secrets
    @if [ "{{os}}" = "Darwin" ]; then \
        if command -v nh >/dev/null; then \
            echo "Updating Darwin system with nh..."; \
            nh darwin switch .; \
        else \
            echo "Updating Darwin system with darwin-rebuild..."; \
            darwin-rebuild switch --flake .; \
        fi \
    elif [ "{{is_nixos}}" = "true" ]; then \
        echo "Updating NixOS system..."; \
        sudo nixos-rebuild switch --flake .#{{host}}; \
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

# Lint GitHub Actions
lint-actions:
    actionlint

# Format all Nix files in the repository
format:
    nix fmt

# Run flake checks to ensure everything is valid
check:
    nix flake check

# Audit for vulnerabilities with a CVSS score of 6.0 or higher
security-scan:
    @DERIVATION=$(nix path-info --derivation {{target}} 2>/tmp/security-scan-error.txt) || { \
        echo "🚨 ERROR: Could not evaluate target {{target}}."; \
        cat /tmp/security-scan-error.txt; \
        exit 1; \
    }; \
    nix shell nixpkgs#vulnix nixpkgs#jq -c sh -c \
    "vulnix --json --whitelist whitelist.toml $DERIVATION | \
    jq -r 'def score: .cvssv3_basescore // {}; [ .[] | { pkg: .name, vulns: [ score | to_entries[] | select(.value >= 6.0) ] } | select(.vulns | length > 0) ] | if length == 0 then \"✅ No High-Risk Vulnerabilities (>= 6.0) detected.\" else \"🚨 HIGH-RISK VULNERABILITIES FOUND:\n\" + (map(\"- \(.pkg)\n  \" + ([.vulns[] | \"\(.key) (Score: \(.value))\"] | join(\"\n  \"))) | join(\"\n\")) end'"

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
    @CURRENT_PATH=$(readlink -f {{current_system}} || echo ""); \
    if [ -z "$CURRENT_PATH" ]; then echo "Current system profile not found."; exit 1; fi; \
    nvd diff $CURRENT_PATH $(nix build --no-link --print-out-paths {{target}})

# Update everything: nix flake, homebrew, and local dotfiles
update-all:
    topgrade

# Show the history of Nix generations
history:
    @nix-env --list-generations --profile {{current_system}}

# Quickly rollback to the previous generation
rollback:
    @if [ "{{os}}" = "Darwin" ]; then \
        sudo /nix/var/nix/profiles/system/bin/switch-to-configuration rollback; \
    elif [ "{{is_nixos}}" = "true" ]; then \
        sudo nixos-rebuild rollback; \
    else \
        home-manager generations | head -n 2 | tail -n 1 | awk '{print $NF}' | xargs -I {} sh -c "{}/activate"; \
    fi

# Explore the dependency graph of the current system (interactive)
explore:
    @CURRENT_PATH=$(readlink -f {{current_system}} || echo ""); \
    if [ -z "$CURRENT_PATH" ]; then echo "Current system profile not found."; exit 1; fi; \
    nix-tree $CURRENT_PATH

# Run a full store optimization to save space
optimize:
    nix-store --optimize

# Edit repository secrets using SOPS
secrets:
    EDITOR=vim sops secrets.yaml

# Verify that all secrets are correctly encrypted
check-secrets:
    @if grep -q "sops:" secrets.yaml; then \
        echo "✅ secrets.yaml appears to be encrypted."; \
    else \
        echo "❌ ERROR: secrets.yaml is NOT encrypted!"; \
        exit 1; \
    fi

# List all deep-dive documentation guides
docs:
    @ls -1 docs/*.md | xargs -n 1 

# Trace why a package is in your closure (usage: just why-depends <pkg-name>)
why-depends pkg:
    nix why-depends {{target}} nixpkgs#{{pkg}}.out