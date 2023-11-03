{ config, containers, ... }: {
  containers.dns = {
    ephemeral = false;
    autoStart = true;
    config = { config, pkgs, ... }: {
      services.adguardhome = { enable = true; };

      networking.firewall.allowedTCPPorts = [ 80 3000 53 ];
      system.stateVersion = "23.05";
    };

  };

}
