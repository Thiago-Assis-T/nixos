{ config, nixos-hardware, ... }: {
  specialisation = {
    performance.configuration = {
      system.nixos.tags = [ "performance" ];
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

}
