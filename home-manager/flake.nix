
{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      archSystem = "x86_64-linux";
      macSystem = "aarch64-darwin";
    in
    {
      homeConfigurations = {
        "ericus" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${archSystem};
          extraSpecialArgs = { inherit nixpkgs; };
          modules = [ ./hosts/arch.nix ];
        };

        "ericpuentes" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${macSystem};
          extraSpecialArgs = { inherit nixpkgs; };
          modules = [ ./hosts/mac.nix ];
        };
      };
    };
}
