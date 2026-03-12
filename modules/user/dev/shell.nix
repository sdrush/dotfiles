{ pkgs, config, ... }:

pkgs.mkShell {
  # Integrates your existing git-hooks/pre-commit configuration
  shellHook = config.pre-commit.installationScript + ''
    echo "🛡️ Security Diet Active: Development persona loaded."
  '';

  packages = with pkgs; [
    # Core Formatting & Linting
    nixfmt
    deadnix
    statix
    shellcheck
    actionlint
    pre-commit
    just
    config.treefmt.build.wrapper

    # Security Diet: Tools moved from modules/user/packages/dev.nix
    python312
    uv
    graphviz
    pylint
    tcl
    tk
  ];
}
