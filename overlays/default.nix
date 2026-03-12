{ inputs, nixpkgsConfig }:

{
  # Overlays to add various packages into package set
  comma = final: _: {
    comma = inputs.comma.packages.${final.system}.default;
  };
  # Overlay useful on Macs with Apple Silicon
  apple-silicon =
    final: _:
    inputs.nixpkgs.lib.optionalAttrs (final.system == "aarch64-darwin") {
      # Add access to x86 packages if system is running Apple Silicon
      pkgs-x86 = import inputs.nixpkgs {
        system = "x86_64-darwin";
        inherit (nixpkgsConfig) config;
      };
    };
}
