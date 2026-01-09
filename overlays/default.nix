{ inputs, nixpkgsConfig }: 

{
  # Overlays to add various packages into package set
  comma = _: prev: {
    comma = inputs.comma.packages.${prev.stdenv.system}.default;
  };  
  # Overlay useful on Macs with Apple Silicon
  apple-silicon = _: prev: inputs.nixpkgs-unstable.lib.optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
    # Add access to x86 packages if system is running Apple Silicon
    pkgs-x86 = import inputs.nixpkgs-unstable {
      system = "x86_64-darwin";
      inherit (nixpkgsConfig) config;
    };
  }; 
}