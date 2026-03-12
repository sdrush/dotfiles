{ pkgs, ... }:

let
  # put a shell script into the nix store
  gitIdentity = pkgs.writeShellScriptBin "git-identity" (builtins.readFile ./scripts/git-identity);
in
{
  # we will use the excellent fzf in our `git-identity` script, so let's make sure it's available
  # Let's add the gitIdentity script to the path as well
  home.packages = with pkgs; [
    gitIdentity
    git-credential-manager
  ];

  # Write the YubiKey public key to a file for Git to use as a signing key
  home.file.".ssh/yubikey.pub".text =
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBHtmxQwSqNg05UQR6AnkT+4aaFEUg4Nc1ISwq/UlmUSH3jB5v0h7YOw+Vi02O+TgVdWGL8IbM2jD7fBq+T6ltq8=";

  programs.git = {
    enable = true;
    settings = {
      # extremely important, otherwise git will attempt to guess a default user identity. see `man git-config` for more details
      init.defaultBranch = "main";
      user = {
        useConfigOnly = true;

        # the `work` identity
        work = {
          name = "Shannon Rush";
          email = "shannon.rush@mavenwave.com";
          signingKey = "~/.ssh/yubikey.pub";
        };

        # the `personal` identity
        personal = {
          name = "Shannon Rush";
          email = "shannon.rush@gmail.com";
          signingKey = "~/.ssh/yubikey.pub";
        };
      };

      # Commit Signing
      commit.gpgsign = true;
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "/usr/bin/ssh-keygen";

      # Set up out default editor and diff tools
      core.editor = "agy --wait";
      diff.tool = "agy";
      "difftool \"agy\"".cmd = "agy --wait --diff $LOCAL $REMOTE";
      merge.tool = "agy";
      "mergetool \"agy\"".cmd = "agy --wait $MERGED";

      # Other important settings
      color.ui = "auto";
      core.autocrlf = "input";
      fetch.prune = true;

      # Pull/Push Safety
      pull.rebase = true; # Keeps history clean by rebasing on pull
      push.autoSetupRemote = true; # Automatically tracks remote branches

      # This is optional, as `git identity` will call the `git-identity` script by itself, however
      # setting it up explicitly as an alias gives you autocomplete
      alias = {
        identity = "! git-identity";
        id = "! git-identity";
        # A Pretty Git Log Graph
        lg = "log --graph --abbrev-commit --decorate --format=format:\"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)\" --all";
      };
    };
  };
}
