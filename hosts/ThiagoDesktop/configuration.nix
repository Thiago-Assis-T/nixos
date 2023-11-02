{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/monero.nix
    ../../modules/networking.nix
    ../../modules/nix.nix
    ../../modules/services.nix
    ../../modules/user.nix
    ../../modules/locale.nix
    ../../modules/boot.nix
    ../../modules/ssh.nix
    ../../modules/tor.nix
    ../../modules/printing.nix
  ];
  environment.systemPackages = with pkgs; [ cpu-x sysbench dmidecode ];

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
