{ config, lib, pkgs, ... }: {
  powerManagement = { powertop.enable = true; };
  services.tlp = {
    enable = true;
    settings = {

    };
  };
}
