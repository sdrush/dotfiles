{ pkgs, ... }:

{
    programs.tmux = {
        enable = true;
        package = pkgs.tmux;
        keyMode = "vi";
        prefix = "C-Space";
        extraConfig = builtins.readFile ./tmux.conf;
    };
}