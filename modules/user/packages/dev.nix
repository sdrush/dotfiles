{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Languages, Language Tools, and Language Packages/Modules
    bfg-repo-cleaner
    jujutsu
    git-absorb

    # Build tools & Libraries (Keeping a few that are commonly used by CLI tools themselves)
    (lib.lowPrio ncurses)
    readline
  ];
}
