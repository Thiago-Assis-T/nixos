{
  description = "NixOS Desktop Config:";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    nix-gaming.url = "github:fufexan/nix-gaming";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, home-manager, nixpkgs, unstable, nixos-hardware
    , utils, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      unstable-pkgs = import unstable {
        inherit system;
        config = { allowUnfree = true; };
      };

    in {

      nixosConfigurations = {
        ThiagoLaptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs unstable-pkgs system; };
          modules = [
            ./hosts/ThiagoLaptop/configuration.nix
            utils.nixosModules.autoGenFromInputs
            nixos-hardware.nixosModules.common-cpu-intel
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
            nixos-hardware.nixosModules.common-pc-laptop
            nixos-hardware.nixosModules.common-pc-laptop-acpi_call
            nixos-hardware.nixosModules.common-gpu-intel
            #nixos-hardware.nixosModules.common-gpu-nvidia-disable
            nixos-hardware.nixosModules.common-gpu-nvidia
            home-manager.nixosModules.home-manager
            inputs.nix-gaming.nixosModules.pipewireLowLatency
            inputs.nix-gaming.nixosModules.steamCompat
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs system pkgs unstable-pkgs;
                };
                users.thiago = import ./home/home.nix;
              };
            }
          ];
        };
        ThiagoDesktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit system pkgs unstable-pkgs inputs; };

          modules = [
            ./hosts/ThiagoDesktop/configuration.nix
            utils.nixosModules.autoGenFromInputs
            nixos-hardware.nixosModules.common-cpu-amd
            # nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
            home-manager.nixosModules.home-manager
            inputs.nix-gaming.nixosModules.pipewireLowLatency
            inputs.nix-gaming.nixosModules.steamCompat
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs system pkgs unstable-pkgs;
                };
                users.thiago = import ./home/home.nix;
              };
            }
          ];
        };
      };

    };
}
