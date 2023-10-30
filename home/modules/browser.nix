{ config, pkgs, ... }: {

  home.packages = with pkgs; [ google-fonts ];
  programs.google-chrome.enable = true;
  programs.brave = {
    enable = true;
    commandLineArgs = [ "-–password-store=basic" ];
  };
}
