{ config, pkgs, ... }: {
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

  hardware.printers = {
    ensurePrinters = [{
      name = "Epson L3150";
      location = "Thiago";
      deviceUri =
        "usb://EPSON/L3150%20Series?serial=583545564232303674&interface=1";
      model = "EPSON L3150 Series";
      ppdOptions = { PageSize = "A4"; };
    }];
  };
  environment.systemPackages = with pkgs; [ system-config-printer ];
}
