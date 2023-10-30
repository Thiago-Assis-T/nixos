{ pkgs, lib, ... }: {
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        htop = "sudo htop";
        rebuildDesktop =
          "cd /home/thiago/nixos; git commit -am '~'; sudo nix flake update; git commit -am '~'; git push; sudo nixos-rebuild switch --upgrade-all --flake ./#ThiagoDesktop;";
      };
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
