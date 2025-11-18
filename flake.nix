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
      flakeRoot = self;
    in {

      
    nixosConfigurations = {
      jaime-nix-gamingdesktop = lib.nixosSystem {
        inherit system;
        modules = [ 
        ./hosts/jaime-nix-gamingdesktop/configuration.nix 
        # Declarative flatpaks
        nix-flatpak.nixosModules.nix-flatpak
        
        ];
        # Flake root to help configurations
        specialArgs = { flakeRoot = flakeRoot; };
      };

      jaime-nix-gaminglaptop = lib.nixosSystem {
        inherit system;
        modules = [ 
        ./hosts/jaime-nix-gaminglaptop/configuration.nix 
        # Declarative flatpaks
        nix-flatpak.nixosModules.nix-flatpak  
        ];

        #Flake root to help configs
        specialArgs = { flakeRoot = flakeRoot; };
      };
    };

    homeConfigurations = {
      jaime-nix-gamingdesktop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/default_gnome/home_x11.nix ];
        extraSpecialArgs = { flakeRoot = flakeRoot; };
      };

      jaime-nix-gaminglaptop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/default_gnome/home_wayland.nix ];
        extraSpecialArgs = { flakeRoot = flakeRoot; };
    };  
  };


}
