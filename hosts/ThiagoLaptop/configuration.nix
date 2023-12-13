{ config, pkgs, nixos-hardware, ... }: {
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

  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = [ "on-the-go" ];
      imports = [ nixos-hardware.nixosModules.common-gpu-nvidia-disable ];
    };

    office.configuration = {
      system.nixos.tags = [ "office" ];
      imports = [ nixos-hardware.nixosModules.common-gpu-nvidia ];

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
    };
  };
  services.xserver.libinput.enable = true;

  networking.hostName = "ThiagoLaptop";

  nix.settings.system-features = [ "gccarch-skylake" ];
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
