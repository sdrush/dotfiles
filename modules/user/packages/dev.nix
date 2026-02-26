{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Languages, Language Tools, and Language Packages/Modules
    bfg-repo-cleaner
    uv # Fast Python package installer and resolver
    python312 # Global interpreter
    graphviz
    jujutsu
    git-absorb
    pylint
    tcl
    tk

    # Build tools & Libraries (Keeping a few that are commonly used by CLI tools themselves)
    (lib.lowPrio ncurses)
    readline
  ];
}
