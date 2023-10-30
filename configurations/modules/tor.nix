{ config, ... }:

{
  services.tor = {
    tsocks = {
      enable = true;
      server = "127.0.0.1:9050";
    };
  };
}
