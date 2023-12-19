{ unstable-pkgs, inputs, config, pkgs, lib, ... }:

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
    packages = with pkgs; [ go gopls gofumpt codeium wl-clipboard htop bat ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      XDG_SESSION_TYPE = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      XCURSOR_SIZE = "20";
      WLR_NO_HARDWARE_CURSORS = "1";
      QT_QPA_PLATFORMTHEME = lib.mkForce "gtk";
    };
  };

  services.gnome-keyring.enable = true;
  xdg.enable = true;
}
