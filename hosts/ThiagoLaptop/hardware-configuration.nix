{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {

    kernelPackages = pkgs.linuxPackages_latest;
    initrd.availableKernelModules =
      [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/58959272-89e5-43ad-a815-da1af0b5e0e8";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/D845-23DA";
      fsType = "vfat";
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/e0c7a13a-0e0c-4726-9dd5-367bfc1face8"; }];

  networking.useDHCP = lib.mkDefault true;
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
