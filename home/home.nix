{ unstable-pkgs, inputs, config, pkgs, ... }:

{
  imports = [
    ./modules/shell.nix
    ./modules/direnv.nix
    ./modules/git.nix
    ./modules/nvim.nix
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
    ];
  };
  services.gnome-keyring.enable = true;
  xdg.enable = true;
}
