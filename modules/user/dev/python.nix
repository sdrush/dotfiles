{ pkgs, ... }:
{
  languages.python = {
    enable = true;
    version = "3.12";
    poetry.enable = true;
    uv.enable = true;
  };

  packages = [
    pkgs.python312Packages.numpy
    pkgs.python312Packages.pyopenssl
  ];
}
