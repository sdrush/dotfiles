{ pkgs, ... }:

let
  # put a shell script into the nix store
  gitIdentity = pkgs.writeShellScriptBin "git-identity" (builtins.readFile ./scripts/git-identity);
  gitSshSign = pkgs.writeShellScriptBin "git-ssh-sign" (builtins.readFile ./scripts/git-ssh-sign);
  yubikeyPublicKey = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBHtmxQwSqNg05UQR6AnkT+4aaFEUg4Nc1ISwq/UlmUSH3jB5v0h7YOw+Vi02O+TgVdWGL8IbM2jD7fBq+T6ltq8=";
in
{
  home = {
    # we will use the excellent fzf in our `git-identity` script, so let's make sure it's available
    # Let's add the gitIdentity script to the path as well
    packages = with pkgs; [
      gitIdentity
      gitSshSign
      git-credential-manager
    ];

    # Write the YubiKey public key to a file for Git to use as a signing key
    file.".ssh/yubikey.pub".text = yubikeyPublicKey;

    # Allowed signers for verification
    file.".ssh/allowed_signers".text = ''
      shannon.rush@mavenwave.com ${yubikeyPublicKey}
      shannon.rush@gmail.com ${yubikeyPublicKey}
    '';
  };

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
          signingKey = "/Users/sdrush/.ssh/yubikey.pub";
        };

        # the `personal` identity
        personal = {
          name = "Shannon Rush";
          email = "shannon.rush@gmail.com";
          signingKey = "/Users/sdrush/.ssh/yubikey.pub";
        };
      };

      # Commit Signing
      commit.gpgsign = true;
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "${gitSshSign}/bin/git-ssh-sign";
      "gpg \"ssh\"".allowedSignersFile = "~/.ssh/allowed_signers";

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
