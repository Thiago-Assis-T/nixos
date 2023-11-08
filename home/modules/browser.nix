{ config, pkgs, ... }: {

  home.packages = with pkgs; [ google-fonts ];
  programs.brave = {
    enable = true;
    commandLineArgs = [ "-–password-store=basic" ];
  };
}
