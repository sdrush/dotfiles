{ inputs, config, ... }:

{
  sops = {
    defaultSopsFile = inputs.self + "/secrets.yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets = {
      "test_secret" = { };
      "cachix_auth_token" = { };
    };

    templates."cachix-token" = {
      content = ''
        export CACHIX_AUTH_TOKEN=${config.sops.placeholder.cachix_auth_token}
      '';
    };
  };

  # This makes the 'sops' CLI tool work automatically
  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };
}
