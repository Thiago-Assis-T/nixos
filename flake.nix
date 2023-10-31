{
  description = "NixOS Desktop Config:";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    hyprland.url = "github:hyprwm/Hyprland";

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = inputs@{ self, home-manager, nixpkgs, nixos-hardware, hyprland
    , home-manager-stable, utils, ... }:
    let
      system = "x86_64-linux";

      unstable = import unstable {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
        };
      };

      home-manager = import home-manager;
      home-manager-stable = import home-manager-stable;
    in {

      nixosConfigurations = {
        ThiagoDesktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit system pkgs inputs; };

          modules = [
            ./hosts/ThiagoDesktop/configuration.nix
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
            home-manager.nixosModules.home-manager-stable
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs hyprland; };
                users.thiago = import ./home/home.nix;
              };
            }
          ];
        };
      };

    };
}
