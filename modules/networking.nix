{ config, hosts, ... }: {

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
  networking = {
    enableIPv6 = true;
    networkmanager = {
      enable = true;
      wifi = { macAddress = "random"; };
    };
    hostFiles = [ hosts ];
    firewall = { enable = true; };
  };

}
