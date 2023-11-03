{ config, ... }:

{
  services.tor = {
    openFirewall = false;
    relay = {
      enable = false;
      role = "relay";
    };
    enable = false;
    tsocks = { enable = false; };
    client = { enable = false; };
  };
}
