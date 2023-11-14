{ unstable-pkgs, inputs, config, pkgs, ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/mako.nix
    ./modules/nvim.nix
    ./modules/hyprland.nix
    ./modules/browser.nix
    ./modules/foot.nix
    ./modules/theming.nix
  ];
  fonts.fontconfig.enable = true;
  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "22.11";
    packages = with pkgs; [
      xfce.thunar
      htop
      unstable-pkgs.slack
      unstable-pkgs.zoom-us
      bat
      popsicle
    ];
  };

  xdg.enable = true;
}
