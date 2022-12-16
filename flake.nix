{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {                                                      # User Package Management
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:msteen/nixos-vscode-server";
    };
  };
  
  outputs = inputs@{ self, nixpkgs, home-manager, vscode-server, ... }: 
    let
      user = "jaylward";
      hostname = "eris";
      location = "$HOME/.flake";
    in
    {
      nixosConfigurations = (
        import ./nixos {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user vscode-server;
        }        
      );
   };
}

