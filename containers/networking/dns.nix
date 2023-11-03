{ config, containers, ... }: {
  containers.wasabi = {
    enable = true;
    ephemeral = true;
    autoStart = true;
    extraFlags = [ " -U " ];
    config = { config, pkgs, ... }: {
      services.httpd.enable = true;
      services.httpd.adminAddr = "foo@example.org";
      networking.firewall.allowedTCPPorts = [ 8000 ];

    };

  };

}
