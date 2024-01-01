{ config, lib, pkgs, ... }: {
  powerManagement = {
    powertop.enable = true;
    powerUpCommands = "${pkgs.powertop}/bin/powertop --autotune";
  };
  services.tlp = {
    enable = true;
    settings = {

    };
  };
}
