{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Security/Secret Management
    sops
    age
    bitwarden-cli
    openssh
    gnupg # GPG for security keys

    # Yubikey tools
    pinentry_mac
    yubico-piv-tool
    yubikey-agent
    yubikey-manager
    yubikey-personalization
  ];
}
