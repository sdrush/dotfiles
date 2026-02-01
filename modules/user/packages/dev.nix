{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Languages, Language Tools, and Language Packages/Modules
    bfg-repo-cleaner
    python312
    graphviz
    jujutsu
    pylint
    tcl
    tk

    # Build tools & Libraries (Keeping a few that are commonly used by CLI tools themselves)
    ncurses
    readline
  ];
}
