{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Security/Secret Management
    sops
    age
    bitwarden-cli
    openssh

    # Yubikey tools
    (if pkgs.stdenv.isDarwin then pinentry_mac else pinentry-curses)
    yubico-piv-tool
    yubikey-agent
    yubikey-manager
    yubikey-personalization
  ];
}
