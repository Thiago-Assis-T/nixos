{ config,  hosts, ... }: {
  networking = {
    networkmanager = {
      enable = true;
      wifi = { macAddress = "random"; };
    };
    hostFiles = [ hosts ];
    firewall = { enable = true; };
  };

}
