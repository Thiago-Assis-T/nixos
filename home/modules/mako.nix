{ config, pkgs, ... }: {
  home.packages = with pkgs; [ libnotify ];

  services.mako = {
    enable = true;
    anchor = "top-right";
    backgroundColor = "#1a1b26";
    borderRadius = 5;
    borderSize = 2;
    defaultTimeout = 3000;
    icons = true;
    maxIconSize = 16;

  };

}
