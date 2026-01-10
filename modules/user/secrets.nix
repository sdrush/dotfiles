{ inputs, ... }:

{
  sops = {
    defaultSopsFile = inputs.self + "/secrets.yaml";
    age.keyFile = "/Users/sdrush/.config/sops/age/keys.txt";
    
    secrets = {
      # We'll add real secrets here soon!
      "test_secret" = { };
    };
  };

  # This makes the 'sops' CLI tool work automatically
  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = "/Users/sdrush/.config/sops/age/keys.txt";
  };
}