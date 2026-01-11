{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.starship;
    settings = {
      # Don't print a new line at the start of the prompt
      add_newline = false;
      kubernetes = {
        format = "[$symbol$context\($namespace\)](dimmed green) ";
        disabled = false;
        context_aliases."dev.local.cluster.k8s" = "dev";
      };
      custom.task_inbox = {
        description = "Task Inbox Count";
        when = "[ 'task +in +PENDING count' == '0' ] && exit 1 || exit 0 ";
        command = "task +in +PENDING count";
        format = "$symbol[$output]($style) ";
        shell = "['zsh', '-d', '-f', '-i'] ";
        symbol = "📥 ";
        style = "bold fg:green";
      };
      gcloud = {
        format = "on [$symbol$account(\($project@$region\))]($style) ";
        symbol = "☁️ ";
        region_aliases = {
          us-central1 = "usc1";
          us-east1 = "use1";
          us-east4 = "use4";
          us-west1 = "usw1";
          us-west2 = "usw2";
          us-west3 = "usw3";
          us-west4 = "usw4";
          northamerica-northeast1 = "nane1";
          southamerica-east1 = "sae1";
          europe-north1 = "eun1";
          europe-west1 = "euw1";
          europe-west2 = "euw2";
          europe-west3 = "euw3";
          europe-west4 = "euw4";
          europe-west6 = "euw6";
          asia-south1 = "as1";
          asia-southeast1 = "ase1";
          asia-southeast2 = "ase2";
          asia-east1 = "ae1";
          asia-east2 = "ae2";
          asia-northeast1 = "ane1";
          asia-northeast2 = "ane2";
          asia-northeast3 = "ane3";
        };
      };
    };
  };
}
