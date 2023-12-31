{ config, ... }: {
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d";
    };
  };
}
