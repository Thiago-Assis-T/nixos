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

  nix.settings.system-features = [ "gccarch-znver3" ];
  nixpkgs = {
    localSystem = {
      system = "x86_64-linux";
      gcc.arch = "znver3";
      gcc.tune = "znver3";
    };
  };

  networking.hostName = "ThiagoDesktop";
  system = {
    stateVersion = "23.05";
    autoUpgrade = {
      enable = true;
      operation = "switch";
      allowReboot = false;
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
