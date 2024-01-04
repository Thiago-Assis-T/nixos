{ config, pkgs, lib, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    shell = "${pkgs.bash}/bin/bash";
  };

}
