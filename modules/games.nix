{ config, pkgs, unstable-pkgs, inputs, ... }: {
  environment.systemPackages =
    [ inputs.nix-gaming.packages.${pkgs.system}.proton-ge ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  hardware.opengl.driSupport32Bit = true;
}
