{

  description = "My first flake!";
  
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05"; # Could have also just done ..nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";..
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
  };
  
  
  
  
  outputs = { self, nixpkgs, home-manager, nix-flatpak, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      nixos-gamingpc = lib.nixosSystem {
        inherit system;
        modules = [ 
        ./configuration.nix 
        # Declarative flatpaks
        nix-flatpak.nixosModules.nix-flatpak
        
        ];
      };
    };
    homeConfigurations = {
      jaime = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };  
  };


}
