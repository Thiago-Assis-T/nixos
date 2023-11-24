{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/games.nix
    ../../modules/networking.nix
    ../../modules/nix.nix
    ../../modules/services.nix
    ../../modules/user.nix
    ../../modules/locale.nix
    ../../modules/boot.nix
    ../../modules/ssh.nix
    ../../modules/printing.nix
  ];

  services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs; [ ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    prime = {
      offload.enable = false;
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  system = {
    stateVersion = "23.05";
    autoUpgrade = {
      enable = true;
      operation = "boot";
      allowReboot = true;
      flake = "/home/thiago/nixos/#ThiagoLaptop";
      flags = [ "--update-input" "nixpkgs" "-L" ];
      dates = "daily";
      rebootWindow = {
        lower = "01:00";
        upper = "03:00";
      };
    };
  };

}
