{ config, nixos-hardware, lib, ... }: {
  specialisation = {
    on-the-go.configuration = {
      powerManagement.cpuFreqGovernor = lib.mkForce "powersave";
      system.nixos.tags = [ "on-the-go" ];
      imports = [ nixos-hardware.nixosModules.common-gpu-nvidia-disable ];
      system.autoUpgrade.enable = lib.mkForce false;

    };
    performance.configuration = {

      powerManagement.cpuFreqGovernor = lib.mkForce "performance";
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
