{ config, ... }: {
  users.users.thiago = {
    isNormalUser = true;
    description = "Thiago";
    extraGroups = [ "wheel" ];
  };
}
