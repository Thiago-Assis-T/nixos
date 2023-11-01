{ pkgs, lib, ... }: {
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = { htop = "sudo htop"; };
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
