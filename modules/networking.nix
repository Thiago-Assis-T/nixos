{ config, hosts, ... }: {
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
  networking = {
    nameservers = [ "::1" "127.0.0.1" ];
    dhcpcd.extraConfig = "nohook resolv.conf";
    enableIPv6 = true;
    networkmanager = {
      enable = true;
      wifi = { macAddress = "random"; };
      dns = "none";
    };
    hostFiles = [ hosts ];
    firewall = {
      enable = true;

    };
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv4_servers = true;
      ipv6_servers = true;
      dnscrypt_servers = true;
      doh_servers = true;
      odoh_servers = true;

      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;

      force_tcp = false;

      listen_addresses = [ "127.0.0.1:53" "[::1]:53" ];
      max_clients = 250;
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key =
          "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };
  services.snowflake-proxy = {
    enable = true;
    capacity = 100;
    stun = "stun:stun.stunprotocol.org:3478";
    relay = "wss://snowflake.bamsoftware.com/";
    broker = "https://snowflake-broker.torproject.net/";
  };
}
