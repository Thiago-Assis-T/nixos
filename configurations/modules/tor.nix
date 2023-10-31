{ config, ... }:

{
  services.tor = {
    enable = true;
    tsocks = {
      enable = true;
      server = "localhost:9050";
    };
  };
}
