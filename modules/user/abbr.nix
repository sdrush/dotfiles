{ lib, ... }:

{
  # zsh-abbr is a Zsh plugin that expands abbreviations as you type.
  # This provides the best of both worlds: short commands for speed,
  # but full commands in your history and on your screen.

  programs.zsh.initContent = lib.mkAfter ''
    # We use zsh-defer to ensure these are added AFTER the plugin is loaded by Home Manager.
    # We also use --quiet to suppress 'already exists' warnings.
    zsh-defer -c "
      # Terraform Abbreviations
      abbr add --quiet tf=terraform
      abbr add --quiet tfa='terraform apply'
      abbr add --quiet tfay='terraform apply -auto-approve'
      abbr add --quiet tfc='terraform console'
      abbr add --quiet tfd='terraform destroy'
      abbr add --quiet tfdy='terraform destroy -auto-approve'
      abbr add --quiet tff='terraform fmt'
      abbr add --quiet tfg='terraform graph'
      abbr add --quiet tfi='terraform init'
      abbr add --quiet tfiu='terraform init -upgrade'
      abbr add --quiet tfim='terraform import'
      abbr add --quiet tfo='terraform output'
      abbr add --quiet tfp='terraform plan'
      abbr add --quiet tfpde='terraform plan --destroy'
      abbr add --quiet tfpr='terraform providers'
      abbr add --quiet tfr='terraform refresh'
      abbr add --quiet tfsh='terraform show'
      abbr add --quiet tft='terraform taint'
      abbr add --quiet tfut='terraform untaint'
      abbr add --quiet tfv='terraform validate'
      abbr add --quiet tfw='terraform workspace'
      abbr add --quiet tfs='terraform state'
      abbr add --quiet tffu='terraform force-unlock'
      abbr add --quiet tfwst='terraform workspace select'
      abbr add --quiet tfwsw='terraform workspace show'
      abbr add --quiet tfwde='terraform workspace delete'
      abbr add --quiet tfwls='terraform workspace list'
      abbr add --quiet tfwnw='terraform workspace new'
      abbr add --quiet tfssw='terraform state show'
      abbr add --quiet tfsls='terraform state list'
      abbr add --quiet tfsmv='terraform state mv'
      abbr add --quiet tfspl='terraform state pull'
      abbr add --quiet tfsph='terraform state push'
      abbr add --quiet tfsrm='terraform state rm'

      # Git Abbreviations
      abbr add --quiet gst='git status'
      abbr add --quiet gd='git diff'
      abbr add --quiet ga='git add'
      abbr add --quiet gaa='git add --all'
      abbr add --quiet gco='git checkout'
      abbr add --quiet gcb='git checkout -b'
      abbr add --quiet gp='git push'
      abbr add --quiet gl='git pull'
      abbr add --quiet gc='git commit -v'
      abbr add --quiet gca='git commit -v -a'
      abbr add --quiet gcam='git commit -m'
      abbr add --quiet gcm='git commit -m'
      abbr add --quiet grb='git rebase'
      abbr add --quiet grba='git rebase --abort'
      abbr add --quiet grbc='git rebase --continue'
      abbr add --quiet grbi='git rebase -i'
      abbr add --quiet gsta='git stash push'
      abbr add --quiet gstp='git stash pop'
      abbr add --quiet gstl='git stash list'

      # Other Abbreviations
      abbr add --quiet kctx=kubectx
      abbr add --quiet kns=kubens
      abbr add --quiet tg=terragrunt
      abbr add --quiet reborn='just rebuild'
      abbr add --quiet dotcfg='\$EDITOR \$DOTFILES'
      abbr add --quiet config='git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME'
      abbr add --quiet mp='man-preview'
      abbr add --quiet myip='curl http://ipecho.net/plain; echo'
      abbr add --quiet ports='netstat -tulanp'
      abbr add --quiet h='history'
      abbr add --quiet l='ls'
      abbr add --quiet pip='python -m pip'
      abbr add --quiet wttr='curl wttr.in'

      # Task Management
      abbr add --quiet in='task add +in'
      abbr add --quiet think='tickle +1d'
      abbr add --quiet tick='tickle'
      abbr add --quiet rnr='read_and_review'
      abbr add --quiet rnd='task add +rnd +next +@computer +@online'
    "
  '';
}
