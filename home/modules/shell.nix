{ pkgs, lib, ... }: {
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        htop = "sudo htop";
        cat = "bat";
      };
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
