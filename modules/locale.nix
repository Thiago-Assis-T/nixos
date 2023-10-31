{ config, ... }: {
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_CA.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };
}
