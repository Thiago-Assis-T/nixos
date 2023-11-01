{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.availableKernelModules =
      [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-amd" ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/63e8dbc8-6720-40b8-8ee4-7ce1e5f3380d";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/1415-ECF7";
      fsType = "vfat";
    };

    "/.moneroNode" = {
      device = "/dev/disk/by-uuid/e1f131f8-83eb-4c06-962e-b4fe7cc1f545";
      fsType = "ext4";
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/edf9e667-375b-48b3-82ab-d1dcdf4b99e9"; }];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;

}
