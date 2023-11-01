{ config, pkgs, ... }: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 5;
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
        memtest86.enable = true;
      };
    };
  };
}
