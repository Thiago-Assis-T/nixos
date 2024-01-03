{ pkgs, ... }: {
  # imports = [ ./snow-flake.nix ];
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
