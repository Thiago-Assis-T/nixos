{ config, ... }:

{
  services.tor = {
    enable = true;
    tsocks = {
      enable = true;
      server = "127.0.0.1:9050";
    };
  };
}
