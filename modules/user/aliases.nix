{ pkgs, lib, ... }:

{
  # I define these aliases here so that I get them regardless of which shell I use.
  programs.zsh.shellAliases = {
    # Some editor aliases for commands that dont like antigravity as the default editor
    sops = "EDITOR=vi sops";
    # These make it marginally more difficult to shoot myself in the foot
    rm = "rm -i";
    cp = "cp -i";

    # Useful default replacement commands
    cat = "bat";

    # Default to modern alternatives
    df = "duf";
    du = "dust";
    ps = "procs";
    dig = "doggo";
    ping = "gping";
    http = "xh";

    ffs = "sudo !!";

    # enable color support of ls and also add handy aliases
    dir = "dir --color=auto";
    vdir = "vdir --color=auto";
    grep = "grep --color=auto";
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";

    ## a quick way to get out of current directory ##
    ".." = "cd ..";
    "..." = "cd ../../";
    "...." = "cd ../../../";
    "....." = "cd ../../../../";
    ".3" = "cd ../../";
    ".4" = "cd ../../../";
    ".5" = "cd ../../../..";
  }
  // lib.optionalAttrs pkgs.stdenv.isDarwin {
    # m-cli (macOS management)
    mac-net = "m network";
    mac-sys = "m system";
    mac-batt = "m battery";
    mac-vol = "m volume";
    mac-display = "m display";
    mac-dnf = "m do-not-disturb";
  };
}
