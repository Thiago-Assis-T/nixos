{ inputs, config, pkgs, unstable, ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/nvim.nix
    ./modules/hyprland.nix
    ./modules/browser.nix
    ./modules/wezterm.nix
  ];
  fonts.fontconfig.enable = true;
  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "22.11";
    packages = with pkgs; [ htop monero-gui unstable.foot ];
  };

}
