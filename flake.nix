{
  description = "My personal NixOS desktop fluke";
  
  inputs = {
    nixpkgs.url =
    "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ...  }:
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
          inherit inputs nixpkgs system home-manager;
        }
      );
    };
}
