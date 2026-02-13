{ pkgs, ... }:
{
  # Universal Cloud & Infrastructure tools
  packages = [
    (pkgs.google-cloud-sdk.withExtraComponents [
      pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.stern
    pkgs.k9s
    pkgs.kops
    pkgs.popeye
    pkgs.lazydocker
    # terraform/terragrunt are handled via tenv (global)
    # but we can ensure they are available in scripts
  ];

  env.USE_GKE_GCLOUD_AUTH_PLUGIN = "true";

  scripts.tf-up.exec = "tenv tf install && tenv tf use && terraform init";
}
