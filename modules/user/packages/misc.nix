{ pkgs, lib, ... }:

{
  home.packages =
    with pkgs;
    [
      # Search/Regex
      grex

      # Calendars/Productivity
      gcalcli
      pandoc

      # Networking
      nmap
      speedtest-cli
      unbound
      xh # Faster httpie alternative

      # SQLite
      sqlite
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      cocoapods
      m-cli # useful macOS CLI commands
    ];
}
