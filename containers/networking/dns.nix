{ config, containers, ... }: {
  containers.dns = {
    ephemeral = true;
    autoStart = true;
    # extraFlags = [ "-U" ];
    additionalCapabilities = [ "CAP_NET_BIND_SERVICE" "CAP_NET_RAW" ];
    allowedDevices = [
      {
        modifier = "rwm";
        node = "/dev/shm";
      }
    ];
    config = { config, pkgs, ... }: {
      services.adguardhome = {
        enable = true;
        settings = {
          bind_host = "0.0.0.0";
          bind_port = 3000;
          theme = "dark";
          debug_pprof = false;
          web_session_ttl = 720;
          dns = {
            bind_host = "0.0.0.0";
            port = 53;
            anonymize_client_ip = true;
            protection_enabled = true;
            blocking_mode = "null_ip";
            ratelimit = 0;
            upstream_dns = [
              "tls://security.cloudflare-dns.com"
              "tls://security-filter-dns.cleanbrowsing.org"
            ];

          };
        };
      };

      networking.firewall.allowedTCPPorts = [ 3000 53 ];
      system.stateVersion = "23.05";
    };

  };

}
