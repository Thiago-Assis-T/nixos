{ config, pkgs, unstable-pkgs, ... }: {
  programs.steam = {
    enable = false;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  hardware.opengl.driSupport32Bit = true;
}
