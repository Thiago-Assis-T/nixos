{ config, ... }: {
  networking = {
    hostName = "ThiagoDesktop";
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
        macAddress = "random";
      };
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [ 18080 18081 9050 9063 ];
    };

  };

}
