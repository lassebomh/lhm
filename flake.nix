{
  description = "LHB home-manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nix-index-database,
    ...
  }: {
    homeManagerModules.default = {
      imports = [./modules];
      config._module.args = {inherit inputs;};
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.pkgs.alejandra;

    homeConfigurations = {
      work = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };

        modules = [
          ./configurations/work
          nix-index-database.hmModules.nix-index
          self.homeManagerModules.default
        ];
      };

      desktop = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };

        modules = [
          ./configurations/desktop
          nix-index-database.hmModules.nix-index
          self.homeManagerModules.default
        ];
      };
    };
  };
}
