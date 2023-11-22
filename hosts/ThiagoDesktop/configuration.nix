{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/games.nix
    ../../modules/networking.nix
    ../../modules/nix.nix
    ../../modules/services.nix
    ../../modules/user.nix
    ../../modules/locale.nix
    ../../modules/boot.nix
    ../../modules/ssh.nix
    ../../modules/printing.nix
  ];
  environment.systemPackages = with pkgs; [ ];

  networking.hostName = "ThiagoDesktop";
  system = {
    stateVersion = "23.05";
    autoUpgrade = {
      enable = true;
      operation = "boot";
      allowReboot = true;
      flake = "/home/thiago/nixos/#ThiagoDesktop";
      flags = [ "--update-input" "nixpkgs" "-L" ];
      dates = "daily";
      rebootWindow = {
        lower = "01:00";
        upper = "03:00";
      };
    };
  };

}
