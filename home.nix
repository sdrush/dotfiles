{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/aliases.nix
    ./modules/git.nix
    ./modules/navi.nix
    ./modules/packages.nix
    ./modules/starship.nix
    ./modules/tmux.nix
    ./modules/zsh.nix
  ];
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  # Man pages
  manual.manpages.enable = true;

  # Alacritty
  # https://github.com/alacritty/alacritty
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.alacritty.enable
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
  };

  # Autojump: a cd command that learns.
  # https://github.com/wting/autojump
  # https://rycee.gitlab.io/home-manager/optio/ns.html#opt-programs.autojump.enable
  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

  # Direnv: load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # FZF: Fuzzy search
  # https://github.com/junegunn/fzf
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.fzf.enable
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.fzf;
  };

  # GH: The github cli
  # https://cli.github.com/
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.gh.enable
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    package = pkgs.gh;
  };

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

# LSD: My favorite ls replacement
programs.lsd = {
  enable = true;
  enableZshIntegration = true;
};
  # VSCode: Visual Studio Code
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default.extensions = [

    ];
  };

  home.sessionPath = [
    "/~.rd/bin"
  ];

  home.file = {
    ".config/alacritty/alacritty.yml".source = ./alacritty.yml;
    # ".warp/workflows/gcloud/set_project.yaml".source = ./set_project.yaml;
  };
}
