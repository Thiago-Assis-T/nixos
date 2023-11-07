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
      allowedTCPPorts = [ 631 18080 18081 3000 ];
      allowedUDPPorts = [ 631 ];
    };
  };

}
