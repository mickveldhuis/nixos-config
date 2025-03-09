{

  description = "Mick's NixOS Flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # The `follows` options makes sure that home-manager stays conistent with nixpkgs!
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      laptop = lib.nixosSystem {
        inherit system;
        modules = [ 
	  ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mick = import ./hosts/laptop/home.nix;
          }
        ];
      };
      desktop = lib.nixosSystem {
        inherit system;
        modules = [ 
	  ./hosts/desktop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mick = import ./hosts/desktop/home.nix;
          }
        ];
      };
    };
    homeConfigurations = {
      laptop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hosts/laptop/home.nix ];
      };
      desktop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hosts/desktop/home.nix ];
      };
    };
  };

}

