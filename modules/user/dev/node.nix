{ pkgs, ... }:
{
  languages.javascript = {
    enable = true;
    package = pkgs.nodejs_22;
    npm.enable = true;
    yarn.enable = true;
    pnpm.enable = true;
  };

  packages = [
    pkgs.nodePackages.typescript
    pkgs.nodePackages.typescript-language-server
  ];
}
