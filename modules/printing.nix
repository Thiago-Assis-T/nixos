{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ system-config-printer ];
  services.printing = {
    enable = true;
    drivers = with pkgs; [ epson-escpr epson-escpr2 ];

    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
  networking.firewall = {
    allowedTCPPorts = [ 631 ];
    allowedUDPPorts = [ 631 ];
  };

}
