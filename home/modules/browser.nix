{ config, pkgs, ... }: {

  home.packages = with pkgs; [ google-fonts ];
  programs.firefox.enable = true;
}
