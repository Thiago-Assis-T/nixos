{ config, pkgs, unstable-pkgs, inputs, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages =
      [ inputs.nix-gaming.packages.${pkgs.system}.proton-ge ];
  };
  hardware.opengl.driSupport32Bit = true;
}
