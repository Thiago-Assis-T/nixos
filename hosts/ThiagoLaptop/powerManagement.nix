{ config, lib, pkgs, ... }: {
  powerManagement = {
    powertop.enable = true;
    scsiLinkPolicy = "min_power";
    powerUpCommands = "${pkgs.powertop}/bin/powertop --autotune";
  };
  services.tlp = {
    enable = true;
    settings = {

    };
  };
}
