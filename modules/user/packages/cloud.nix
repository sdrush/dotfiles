{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Container Stuff
    docker-compose
    dive
    kubectl
    kubectx
    kops
    kubernetes-helm
    popeye
    stern

    # Cloud stuff
    (google-cloud-sdk.withExtraComponents [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    terraform
    terraformer
    terragrunt
    tflint
  ];
}
