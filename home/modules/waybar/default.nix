{ config, pkgs, lib, ... }: {

  programs.waybar = {
    enable = true;
systemd = {
  enable = true;
  target = "hyprland-session.target";
};

  };
}
