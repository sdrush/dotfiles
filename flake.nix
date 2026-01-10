{
  description = "Shannon's Darwin Flake";

  inputs = {
    # Nix package sets
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Nix-darwin and home-manager
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    comma.url = "github:nix-community/comma";

    # Flake Parts
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Nix Index
    nix-index-database.url = "github:nix-community/nix-index-database";

    # SOPS-Nix
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    inputs@{
      self,
      darwin,
      flake-parts,
      home-manager,
      nixpkgs-unstable,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      # 1. Per-System Configuration (Automatic for each system in 'systems')
      perSystem =
        {
          pkgs,
          system,
          ...
        }:
        {
          # Automatically sets up formatter
          formatter = pkgs.nixfmt-rfc-style;

          # Automatically sets up devShells
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              nixfmt-rfc-style
              deadnix
              statix
            ];
          };

          packages =
            if system == "aarch64-darwin" then
              {
                default = self.darwinConfigurations.typhon.config.system.build.toplevel;
              }
            else
              { };
        };

      # 2. Global Configuration
      flake = {
        darwinConfigurations =
          let
            user = "sdrush";
            # Configuration for `nixpkgs` inside darwinConfigurations
            nixpkgsConfig = {
              config = {
                allowUnfree = true;
              };
              overlays = nixpkgs-unstable.lib.attrValues self.overlays;
            };
          in
          {
            typhon = darwin.lib.darwinSystem {
              system = "aarch64-darwin";
              specialArgs = { inherit inputs user; };
              modules = [
                # Main `nix-darwin` config
                ./configuration.nix
                # `home-manager` module
                home-manager.darwinModules.home-manager
                {
                  nixpkgs = nixpkgsConfig;
                  # `home-manager` config
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = { inherit inputs; };
                    users."${user}" = {
                      imports = [
                        ./home.nix
                        inputs.nix-index-database.homeModules.nix-index
                        inputs.sops-nix.homeManagerModules.sops
                      ];
                    };
                  };
                }
              ];
            };
          };

        # Overlays
        overlays = import ./overlays/default.nix {
          inherit inputs;
          nixpkgsConfig = {
            config = {
              allowUnfree = true;
            };
          };
        };
      };
    };
}
