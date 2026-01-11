{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Languages, Language Tools, and Language Packages/Modules
    bfg-repo-cleaner
    go
    lua5_4
    nodejs_22
    python312
    python312Packages.numpy
    python312Packages.pyopenssl
    graphviz
    temurin-jre-bin-17
    jujutsu
    pylint
    tcl
    tk

    # Build tools & Libraries
    autoconf
    gnupg
    gnutls
    ldns # DNS Library and drill
    ncurses
    nghttp2
    oath-toolkit
    openssl
    readline
    unibilium
  ];
}
