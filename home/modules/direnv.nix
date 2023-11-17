{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    direnv.nix-direnv.enable = true;
  };

}
