{
  description = "Shannon's Darwin Flake";

  inputs = {
    # nixpkgs.stable.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    comma.url = "github:nix-community/comma";
    comma.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      darwin,
      flake-parts,
      home-manager,
      nixpkgs,
      treefmt-nix,
      git-hooks,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        git-hooks.flakeModule
        treefmt-nix.flakeModule
      ];
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      # 1. Per-System Configuration (Automatic for each system in 'systems')
      perSystem =
        {
          pkgs,
          system,
          config,
          ...
        }:
        {
          pre-commit = {
            check.enable = true;
            settings.hooks = {
              treefmt.enable = true; # Runs your current nix fmt/treefmt config
              statix.enable = true; # Catch bad Nix patterns
              deadnix.enable = true; # Catch unused variables
            };
          };
          # Treefmt configuration
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
              shfmt.enable = true;
              prettier.enable = true;
            };
            settings.global.excludes = [
              "flake.lock"
              "secrets.yaml"
              "poetry.lock"
            ];
          };
          # Automatically sets up devShells
          devShells.default = pkgs.mkShell {
            shellHook = config.pre-commit.installationScript;
            packages = with pkgs; [
              nixfmt
              deadnix
              statix
              config.treefmt.build.wrapper
            ];
          };

          packages =
            if system == "aarch64-darwin" then
              {
                default = self.darwinConfigurations.typhon.config.system.build.toplevel;
              }
            else
              { };

          checks =
            let
              # Helper to filter checks by system
              platformChecks =
                if system == "aarch64-darwin" then
                  {
                    darwin-typhon = self.darwinConfigurations.typhon.config.system.build.toplevel;
                  }
                else if system == "x86_64-linux" then
                  {
                    nixos-wsl = self.nixosConfigurations.nixos.config.system.build.toplevel;
                    home-apollo = self.homeConfigurations."sdrush@APOLLO".activationPackage;
                  }
                else
                  { };
            in
            platformChecks // { inherit (config.pre-commit) check; };
        };

      # 2. Global Configuration
      flake = {
        darwinConfigurations =
          let
            user = "sdrush";
          in
          {
            typhon = darwin.lib.darwinSystem {
              system = "aarch64-darwin";
              specialArgs = { inherit inputs user; };
              modules = [
                # Main `nix-darwin` config
                ./configuration.nix
                ./modules/user/stylix.nix
                inputs.stylix.darwinModules.stylix
                {
                  nixpkgs = {
                    config.allowUnfree = true;
                    overlays = nixpkgs.lib.attrValues self.overlays;
                  };
                }
                # `home-manager` module
                home-manager.darwinModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    backupFileExtension = "backup";
                    extraSpecialArgs = { inherit inputs; };
                    users."${user}" = {
                      imports = [
                        ./home.nix
                        inputs.nix-index-database.homeModules.nix-index
                        inputs.sops-nix.homeManagerModules.sops
                        inputs.nixvim.homeModules.nixvim
                      ];
                    };
                  };
                }
              ];
            };
          };

        nixosConfigurations = {
          nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              inputs.nixos-wsl.nixosModules.default
              ./hosts/nixos/configuration.nix
              inputs.stylix.nixosModules.stylix
              ./modules/user/stylix.nix
              home-manager.nixosModules.home-manager
              {
                nixpkgs = {
                  config.allowUnfree = true;
                  overlays = nixpkgs.lib.attrValues self.overlays;
                };
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs; };
                  users.sdrush = {
                    imports = [
                      ./home.nix
                      inputs.nix-index-database.homeModules.nix-index
                      inputs.sops-nix.homeManagerModules.sops
                      inputs.nixvim.homeModules.nixvim
                    ];
                  };
                };
              }
            ];
          };
        };

        systemConfigs = { };

        homeConfigurations = {
          "sdrush@APOLLO" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
              overlays = builtins.attrValues self.overlays;
            };
            modules = [
              ./home.nix
              ./modules/user/stylix.nix
              ./modules/user/stylix-linux.nix
              inputs.nix-index-database.homeModules.nix-index
              inputs.sops-nix.homeManagerModules.sops
              inputs.nixvim.homeModules.nixvim
              inputs.stylix.homeModules.stylix
              (
                { lib, ... }:
                {
                  home = {
                    username = "sdrush";
                    homeDirectory = lib.mkForce "/home/sdrush";
                    stateVersion = "24.11";
                  };
                }
              )
            ];
            extraSpecialArgs = { inherit inputs; };
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
