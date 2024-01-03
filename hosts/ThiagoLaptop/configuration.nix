{ config, pkgs, nixos-hardware, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./powerManagement.nix
    ../../modules/networking.nix
    ../../modules/nix.nix
    ../../modules/services.nix
    ../../modules/user.nix
    ../../modules/locale.nix
    ../../modules/boot.nix
    ../../modules/ssh.nix
    ../../modules/printing.nix
    ../../modules/universalContainers
  ];
  services.xserver.libinput.enable = true;

  networking.hostName = "ThiagoLaptop";
  environment.systemPackages = with pkgs; [ brightnessctl ];

  nix.settings.system-features = [ "big-parallel" "gccarch-skylake" ];
  nixpkgs = {
    localSystem = {
      system = "x86_64-linux";
      gcc.arch = "skylake";
      gcc.tune = "skylake";
    };
  };
  system = {
    stateVersion = "23.05";
    autoUpgrade = {
      enable = true;
      operation = "boot";
      allowReboot = false;
      flake = "/home/thiago/nixos/#ThiagoLaptop";
      flags = [ "--update-input" "nixpkgs" "-L" ];
      dates = "daily";
    };
  };

}
