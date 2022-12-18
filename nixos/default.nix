{ lib, inputs, nixpkgs, home-manager, user, vscode-server, ... }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
  };

  lib = nixpkgs.lib;
in
{
  eris = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user;
      host = {
        hostName = "eris";
      };
    };
    modules = [
      ./configuration.nix
    
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)];
        };
      }
      vscode-server.nixosModule {
        services.vscode-server.enable = true;
      }

      {
        services.postgresql = {
          enable = true;
          package = pkgs.postgresql_11;
        };
      }
    ];
  };
}
