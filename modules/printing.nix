{ config, pkgs, ... }: {
  services.printing = {
    enable = true;
    drivers = with pkgs; [ epson-escpr epson-escpr2 ];
  };
  environment.systemPackages = with pkgs; [ system-config-printer ];

}
