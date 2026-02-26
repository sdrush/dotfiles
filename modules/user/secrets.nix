{ inputs, config, ... }:

{
  sops = {
    defaultSopsFile = inputs.self + "/secrets.yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets = {
      # We'll add real secrets here soon!
      "test_secret" = { };
    };
  };

  # This makes the 'sops' CLI tool work automatically
  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };
}
