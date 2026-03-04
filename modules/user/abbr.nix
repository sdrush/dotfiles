{ lib, ... }:

let
  # zsh-abbr is a Zsh plugin that expands abbreviations as you type.
  # This provides the best of both worlds: short commands for speed,
  # but full commands in your history and on your screen.
  #
  # We define them here in a Nix attrset so we can dynamically
  # populate YSU_IGNORED_ALIASES to prevent zsh-you-should-use
  # from complaining about the expanded abbreviations.
  abbreviations = {
    # Git
    gst = "git status";
    gd = "git diff";
    ga = "git add";
    gaa = "git add --all";
    gco = "git checkout";
    gcb = "git checkout -b";
    gp = "git push";
    gl = "git pull";
    gc = "git commit -v";
    gca = "git commit -v -a";
    gcam = "git commit -m";
    gcm = "git commit -m";
    grb = "git rebase";
    grba = "git rebase --abort";
    grbc = "git rebase --continue";
    grbi = "git rebase -i";
    gsta = "git stash push";
    gstp = "git stash pop";
    gstl = "git stash list";

    # Terraform
    tf = "terraform";
    tfa = "terraform apply";
    tfay = "terraform apply -auto-approve";
    tfc = "terraform console";
    tfd = "terraform destroy";
    tfdy = "terraform destroy -auto-approve";
    tff = "terraform fmt";
    tfg = "terraform graph";
    tfi = "terraform init";
    tfiu = "terraform init -upgrade";
    tfim = "terraform import";
    tfo = "terraform output";
    tfp = "terraform plan";
    tfpde = "terraform plan --destroy";
    tfpr = "terraform providers";
    tfr = "terraform refresh";
    tfsh = "terraform show";
    tft = "terraform taint";
    tfut = "terraform untaint";
    tfv = "terraform validate";
    tfw = "terraform workspace";
    tfs = "terraform state";
    tffu = "terraform force-unlock";
    tfwst = "terraform workspace select";
    tfwsw = "terraform workspace show";
    tfwde = "terraform workspace delete";
    tfwls = "terraform workspace list";
    tfwnw = "terraform workspace new";
    tfssw = "terraform state show";
    tfsls = "terraform state list";
    tfsmv = "terraform state mv";
    tfspl = "terraform state pull";
    tfsph = "terraform state push";
    tfsrm = "terraform state rm";

    # Others
    kctx = "kubectx";
    kns = "kubens";
    tg = "terragrunt";
    reborn = "just rebuild";
    dotcfg = "\\$EDITOR \\$DOTFILES";
    config = "git --git-dir=\\$HOME/.cfg/ --work-tree=\\$HOME";
    mp = "man-preview";
    myip = "curl http://ipecho.net/plain; echo";
    ports = "netstat -tulanp";
    h = "history";
    l = "ls";
    pip = "python -m pip";
    wttr = "curl wttr.in";

    # Task Management
    "in" = "task add +in";
    think = "tickle +1d";
    tick = "tickle";
    rnr = "read_and_review";
    rnd = "task add +rnd +next +@computer +@online";
  };

  # Generate YSU ignore list
  # We add 'g' (git) and 'k' (kubectl) specifically because they are common base aliases
  # that trigger fallback warnings when abbreviations expand to their full forms.
  ysu_ignores = lib.concatStringsSep " " (
    (lib.attrNames abbreviations)
    ++ [
      "g"
      "k"
    ]
  );

  # Generate abbr add commands
  abbr_commands = lib.concatStringsSep "\n      " (
    lib.mapAttrsToList (name: value: "abbr add --quiet ${name}='${value}'") abbreviations
  );
in
{
  programs.zsh.initContent = lib.mkAfter ''
    # Silence YSU for abbreviations
    export YSU_IGNORED_ALIASES=(${ysu_ignores})

    # We use zsh-defer to ensure these are added AFTER the plugin is loaded by Home Manager.
    zsh-defer -c "
      ${abbr_commands}
    "
  '';
}
