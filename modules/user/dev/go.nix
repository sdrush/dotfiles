{ pkgs, ... }:
{
  languages.go.enable = true;

  packages = [
    pkgs.go-tools
    pkgs.golangci-lint
    pkgs.delve
  ];

  scripts.go-test.exec = "go test ./...";
}
