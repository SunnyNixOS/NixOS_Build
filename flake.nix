{

  description = "Sunny's Gaming PC Flake";
  
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05"; # Could have also just done ..nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";..
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  
  
  
  outputs = { self, nixpkgs, home-manager, nix-flatpak, nix4nvchad, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      flakeRoot = self;
      de = "gnome"; # change DE here to gnome, kde, hyprland
    in {

      
    nixosConfigurations = {
      jaime-nix-gamingdesktop = lib.nixosSystem {
        inherit system;
        modules = [ 
        ./hosts/jaime-nix-gamingdesktop/configuration.nix 
        # Declarative flatpaks
        nix-flatpak.nixosModules.nix-flatpak
        ];
        #Flake root to help config; de to choose Desktop Environment
        specialArgs = { 
          flakeRoot = flakeRoot;
          de = de;
          };
      };

      jaime-nix-gaminglaptop = lib.nixosSystem {
        inherit system;
        modules = [ 
        ./hosts/jaime-nix-gaminglaptop/configuration.nix 
        # Declarative flatpaks
        nix-flatpak.nixosModules.nix-flatpak  
        ];

        #Flake root to help config; de to choose Desktop Environment
        specialArgs = { 
          flakeRoot = flakeRoot;
          de = de;
          };
      };
    };

    # Different home-manager configurations depending on your chosen DE. Just do "home-manager switch --flake .#DE" (replace "DE" with gnome, kde, hyprland)
    homeConfigurations = {
      gnome = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/gnome/home.nix ];
        extraSpecialArgs = { flakeRoot = flakeRoot; };
      };

      kde = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/kde/home.nix ];
        extraSpecialArgs = { flakeRoot = flakeRoot; };
    };  
      hyprland = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          nix4nvchad.homeManagerModules.nvchad
          ./home/hyprland/home.nix
          ];

          
        extraSpecialArgs = { 
          flakeRoot = flakeRoot;
          };
    }; 
  };
    };
}
