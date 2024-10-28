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
      mkConfig = (name: {
        name = name;
        value = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./configurations/${name}
            self.homeManagerModules.default
          ];
        };
      });
    in {
      homeManagerModules = rec {
        modules = import ./modules;
        default = modules;
      };
      homeConfigurations = (builtins.listToAttrs [
        (mkConfig "desktop")
        (mkConfig "work")
      ]);
    };
}