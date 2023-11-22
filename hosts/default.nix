{ lib, inputs, nixpkgs, home-manager, ... }:

let
  system = "x86_64-linux";                                  # System Architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow Proprietary Software
  };

  lib = nixpkgs.lib;
in
{
  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system;
      host = {
        hostName = "nietos";
      };
    };
    modules = [
      ./desktop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.patrik = {
          imports = [(import ./home.nix)];
        };
      }
    ];
  };

  # TODO
  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system;
      host = {
        hostName = "kinos";
      };
    };
    modules = [
      ./laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.patrik = {
          imports = [(import ./home.nix)];
        };
      }
    ];
  };
}
