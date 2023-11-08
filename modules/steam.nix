{ config, pkgs, unstable-pkgs, ... }: {
  environment.systemPackages = with pkgs; [ ];
  programs.steam = {
    enable = true;
    package = unstable-pkgs.steam;
  };
  hardware = {
    opengl.driSupport32Bit = true;
    steam-hardware.enable = true;
  };
}
