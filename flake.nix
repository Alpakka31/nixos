{
  description = "My personal NixOS desktop fluke";
  
  inputs = {
    nixpkgs.url =
    "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {                                                          # Official Hyprland Flake
      url = "github:hyprwm/Hyprland";                                     # Requires "hyprland.nixosModules.default" to be added the host modules
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, ...  }:
    let
     system = "x86_64-linux";
     pkgs = import nixpkgs {
       inherit system;
       config.allowUnfree = true;
     };

     lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs system home-manager hyprland;
        }
      );
    };
}
