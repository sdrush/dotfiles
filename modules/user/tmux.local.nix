{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    keyMode = "vi";
    prefix = "C-Space";
    tmuxinator.enable = true;
    extraConfig = ''
      set-option default-terminal "screen-256color"
      # unbind C-Space
      # set -g prefix C-Space
      # bind C-Space send-prefix
      set -g mouse on
      set-option -g history-limit 5000
      set -g renumber-windows on

      bind-key "|" split-window -h -c "#{pane_current_path}"
      bind-key "\\" split-window -fh -c "#{pane_current_path}"

      bind-key "-" split-window -v -c "#{pane_current_path}"
      bind-key "_" split-window -fv -c "#{pane_current_path}"

      bind -r "<" swap-window -d -t -1
      bind -r ">" swap-window -d -t +1

      bind c new-window -c "#{pane_current_path}"

      bind Space last-window
    '';
  };
}
