{ config, pkgs, lib, ... }: {

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = builtins.readFile ./settings;
    style = builtins.readFile ./style.css;

  };
}
