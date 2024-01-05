{ config, pkgs, lib, ... }: {
  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    clock24 = true;
    keyMode = "vi";
    newSession = true;
    baseIndex = 1;
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
    '';
  };

}
