{ config, ... }:

{
  services = {
    monero = {
      enable = false;
      dataDir = "/home/thiago/.moneroNode";
      priorityNodes =
        [ "p2pmd.xmrvsbeast.com:18080" "nodes.hashvault.pro:18080" ];
      rpc = {
        address = "0.0.0.0";
        port = 18081;
        restricted = true;
      };
      extraConfig = ''
        enforce-dns-checkpointing=1
        public-node=1
        confirm-external-bind=1
      '';
    };

    xmrig = {
      enable = false;
      settings = {
        donate-level = 0;
        pause-on-battery = true;
        pause-on-active = false;
        retries = 3;
        prioriy = 1;
        memory-pool = false;
        asm = "ryzen";
        tls = false;
        yield = false;
        cpu = true;
        opencl = false;
        cuda = false;
        pools = [ ];
      };
    };
  };
}
