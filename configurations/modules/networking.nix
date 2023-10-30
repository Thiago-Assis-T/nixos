{ config, ... }: {
  networking = {
    hostName = "ThiagoDesktop";
    firewall.enable = true;
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
        macAddress = "random";
      };
    };

  };

}
