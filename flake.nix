{
  description = "Shannon's Darwin Flake";

  inputs = {
    # nixpkgs.stable.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs.url = "github:NixOS/nixpkgs/72b1d820cb0149b40a35aa077b4b6d60cd1b23c3"; # nixpkgs-unstable
    darwin.url = "github:lnl7/nix-darwin/52d061516108769656a8bd9c6e811c677ec5b462"; # master
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/924e61f5c2aeab38504028078d7091077744ab17";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    comma.url = "github:nix-community/comma/7dc70f2abac10664bc0ac2be8932cabf0eae81a9";
    comma.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts/f20dc5d9b8027381c474144ecabc9034d6a839a3";
    nix-index-database.url = "github:nix-community/nix-index-database/a2051ff239ce2e8a0148fa7a152903d9a78e854f";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix/1d9b98a29a45abe9c4d3174bd36de9f28755e3ff";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix/337a4fe074be1042a35086f15481d763b8ddc0e7";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/c4b8e80a1020e09a1f081ad0f98ce804a6e85acf";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim/21ae25e13b01d3b4cdc750b5f9e7bad68b150c10";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    git-hooks.url = "github:cachix/git-hooks.nix/6e34e97ed9788b17796ee43ccdbaf871a5c2b476"; # git-hooks.nix -> git-hooks in flake.nix
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";

    system-manager.url = "github:numtide/system-manager/aa740af1b7919a9969325b91ef59890ea54ecace";
    system-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/be894604b2aa2184c0b3d3b44995acd0da14dc0c";
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
              detect-private-keys.enable = true; # Prevent committing secrets
              shellcheck.enable = true; # Lint shell scripts
              commitizen.enable = true; # Enforce conventional commits
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
          # Automatically sets up devShells using your dev persona directory
          devShells.default = import ./modules/user/dev/shell.nix { inherit pkgs config; };

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
            platformChecks;
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
                ./modules/system/cachix.nix
                ./modules/system/security.nix
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
              ./modules/system/cachix.nix
              ./modules/system/security.nix
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

        systemConfigs = {
          default = inputs.system-manager.lib.makeSystemConfig {
            modules = [
              ./modules/linux/system.nix
              ./modules/system/cachix.nix
              ./modules/system/security.nix
              (
                { pkgs, ... }:
                {
                  nixpkgs.hostPlatform = "x86_64-linux";
                  nix.package = pkgs.nix;
                }
              )
            ];
          };
        };

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
              ./modules/system/cachix.nix
              ./modules/system/security.nix
              (
                { pkgs, ... }:
                {
                  nix.package = pkgs.nix;
                }
              )
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
