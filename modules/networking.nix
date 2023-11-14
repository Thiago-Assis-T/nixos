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
    firewall = { enable = true; };
  };

}
