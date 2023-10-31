{ config, ... }:

{
  services.tor = {
    openFirewall = true;
    relay = {
      enable = false;
      role = "relay";
    };
    enable = true;
    tsocks = { enable = true; };
    client = { enable = true; };
  };
}
