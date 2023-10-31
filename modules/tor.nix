{ config, ... }:

{
  services.tor = {
    openFirewall = true;
    relay = {
      enable = true;
      role = "relay";
    };
    enable = true;
    tsocks = { enable = true; };
    client = { enable = true; };
  };
}
