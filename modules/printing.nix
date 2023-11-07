{ config, pkgs, ... }: {
  services.samba = {
    enable = true;
    package = pkgs.sambaFull;
    openFirewall = true; # Automatically open firewall ports
    extraConfig = ''
      load printers = yes
      printing = cups
      printcap name = cups
    '';
    shares = {
      printers = {
        comment = "All Printers";
        path = "/var/spool/samba";
        public = "yes";
        browseable = "yes";
        # to allow user 'guest account' to print.
        "guest ok" = "yes";
        writable = "no";
        printable = "yes";
        "create mode" = 700;
      };
    };
  };
  systemd.tmpfiles.rules = [ "d /var/spool/samba 1777 root root -" ];
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

  environment.systemPackages = with pkgs; [ system-config-printer ];

  # hardware.printers = {
  #   ensurePrinters = [{
  #     name = "Epson_L3150_Thiago";
  #     location = "Thiago";
  #     deviceUri =
  #       "usb://EPSON/L3150%20Series?serial=583545564232303674&interface=1";
  #     model = "epson-escpr.ppd";
  #     ppdOptions = { PageSize = "A4"; };
  #   }];
  # };
}
