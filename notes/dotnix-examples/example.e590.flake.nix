{
  description = "My First flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    # add home-manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.${system}; # see modified snippet below
      # allowUnfree packages
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config ={
          allowUnfree = true;
        };
      };
    in

    {
      nixosConfigurations = {
        delliprecinix = lib.nixosSystem {
          # system = "x86_64-linux";
          # duplication of above so just use inherit
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
      homeConfigurations = {
        eriberttom =  home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };

}
