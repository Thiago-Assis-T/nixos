{ config, pkgs, unstable-pkgs, inputs, ... }: {

  environment.systemPackages = with pkgs; [ heroic ];
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      gamescopeSession.enable = true;
      extraCompatPackages =
        [ inputs.nix-gaming.packages.${pkgs.system}.proton-ge ];
    };
  };
  hardware.opengl.driSupport32Bit = true;
}
