{ config, ... }: {
  services.mako = {
    enable = true;
    anchor = "top-right";
    backgroundColor = "#1a1b26";
    borderRadius = "5";
    defaultTimeout = "6500";
    icons = true;

  };

}
