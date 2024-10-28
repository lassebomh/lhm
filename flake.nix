{
  description = "LHB home-manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      homeConfigurations = {
        desktop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./configurations/desktop
            self.homeManagerModules.default
          ];
        };
        
        work = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./configurations/work
            self.homeManagerModules.default
          ];
        };
      };
      homeManagerModules = rec {
        modules = import ./modules;
        default = modules;
      };
    };
}