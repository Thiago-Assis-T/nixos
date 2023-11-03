{ config, containers, ... }: {
  containers.dns = {
    ephemeral = false;
    autoStart = true;
    config = { config, pkgs, ... }: {
      services.adguardhome = {
        enable = true;
        mutableSettings = true;
        openFirewall = true;
        settings.bind_port = 3000;
      };

      networking.firewall.allowedTCPPorts = [ 53 ];

      system.stateVersion = "23.05";
    };

  };

}
