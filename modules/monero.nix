{ config, ... }:

{
  services = {
    monero = {
      enable = true;
      dataDir = "/.moneroNode";
      limits.upload = 1048576;
      limits.download = 1048576;
      rpc = {
        address = "127.0.0.1";
        port = 18081;
        restricted = true;
      };
      priorityNodes = [
        "p2pmd.xmrvsbeast.com:18080"
        "nodes.hashvault.pro:18080"
        "xcccrsxi2zknef6zl3sviasqg4xnlkh5k3xqu7ytwkpfli3huyfvsjid.onion:18083"
        "ozeavjybjbxbvmfcpxzjcn4zklbgohjwwndzenjt44pypvx6jisy74id.onion:18083"
        "4egylyolrzsk6rskorqvocipdo4tqqoyzxnplbjorns7issmgpoxvtyd.onion:18083"
        "fagmobguo6u4z4b2ghyg3jegcdpmd4qj4wxkhemph5d5q6dltllveqyd.onion:18083"
        "monerokdwzyuml7vfp73fjx5277lzesbrq4nvbl3r3t5ctgodsx34vid.onion:18089"
        "b75obarnhi42p7js7wgzo7v3wtiwcgf4bknrwv6ihatop77jivrtwpid.onion:15892"
        "5nvd6jbefgto3u74nzzdkcsbqgxyzrkk7bz5qupsdqg4gbuj5valiaqd.onion:18083"
      ];
      extraConfig = ''
        enforce-dns-checkpointing=1
        public-node=1
        confirm-external-bind=1
        limit-rate=1000
        p2p-bind-ip=127.0.0.1
        p2p-bind-port=18080
        no-igd=1
        no-zmq=1
        rpc-ssl=autodetect
        db-sync-mode=safe
        add-peer=4egylyolrzsk6rskorqvocipdo4tqqoyzxnplbjorns7issmgpoxvtyd.onion:18083
        add-peer=fagmobguo6u4z4b2ghyg3jegcdpmd4qj4wxkhemph5d5q6dltllveqyd.onion:18083
        add-peer=monerokdwzyuml7vfp73fjx5277lzesbrq4nvbl3r3t5ctgodsx34vid.onion:18089
        add-peer=b75obarnhi42p7js7wgzo7v3wtiwcgf4bknrwv6ihatop77jivrtwpid.onion:15892
        add-peer=5nvd6jbefgto3u74nzzdkcsbqgxyzrkk7bz5qupsdqg4gbuj5valiaqd.onion:18083
        add-peer=ozeavjybjbxbvmfcpxzjcn4zklbgohjwwndzenjt44pypvx6jisy74id.onion:18083
        add-peer=xcccrsxi2zknef6zl3sviasqg4xnlkh5k3xqu7ytwkpfli3huyfvsjid.onion:18083
        disable-rpc-ban=1
        tx-proxy=tor,127.0.0.1:9050,16
      '';
    };
  };
}