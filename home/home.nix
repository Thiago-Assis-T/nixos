{ inputs, config, pkgs, ... }:

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
    packages = with pkgs; [ htop monero-gui foot ];

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    # gtk = {
    #   enable = true;
    #   theme.package = pkgs.arc-theme;
    #   theme.name = "Arc-Dark";
    #   iconTheme.package = pkgs.arc-icon-theme;
    #   iconTheme.name = "Arc";
    # };

    xdg.enable = true;
  };

}
