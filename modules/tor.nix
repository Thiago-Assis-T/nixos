{ config, ... }:

{
  services.tor = {
    enable = true;
    tsocks = {
      enable = true;
    };
    client = {
      enable = true;
    };
  };
}
