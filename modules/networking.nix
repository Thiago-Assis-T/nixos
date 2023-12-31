{ config, hosts, ... }: {
  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
  networking = {
    networkmanager = {
      enable = true;
      wifi = { macAddress = "random"; };
    };
    hostFiles = [ hosts ];
    firewall = { enable = true; };
  };

}
