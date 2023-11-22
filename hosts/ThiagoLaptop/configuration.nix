{ config, pkgs, ... }:
{
  imports = [ 
    ./hardware-configuration.nix
    #../../modules/games.nix
    ../../modules/networking.nix
    ../../modules/nix.nix
    ../../modules/services.nix
    ../../modules/user.nix
    ../../modules/locale.nix
    ../../modules/boot.nix
    ../../modules/ssh.nix
    ../../modules/printing.nix
  ];

  services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs; [ ];

  system.stateVersion = "23.05";

}
