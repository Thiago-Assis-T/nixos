{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ powertop ];
  powerManagement = {
    powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave";
  };
  services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE = 1;
      TLP_DEFAULT_MODE = "BAT";
      TLP_PERSISTENT_DEFAULT = 1;
      MAX_LOST_WORK_SECS_ON_AC = 15;
      MAX_LOST_WORK_SECS_ON_BAT = 60;
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_MIN_FREQ_ON_BAT = 400000;
      CPU_SCALING_MAX_FREQ_ON_BAT = 2500000;
      CPU_HWP_ON_BAT = "power";
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 45;
      CPU_BOOST_ON_BAT = 0;
      SCHED_POWERSAVE_ON_BAT = 1;
      NMI_WATCHDOG = 0;
      ENERGY_PERF_POLICY_ON_BAT = "powersave";
      SATA_LINKPWR_ON_BAT = "min_power";
      AHCI_RUNTIME_PM_ON_BAT = "on";
      PCIE_ASPM_ON_BAT = "powersave";
      WIFI_PWR_ON_BAT = "on";
      WOL_DISABLE = "Y";
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";
      RUNTIME_PM_ON_BAT = "on";
      RUNTIME_PM_DRIVER_BLACKLIST = "nouveau nvidia";
      USB_AUTOSUSPEND = 1;
      USB_BLACKLIST_BTUSB = 1;
      USB_BLACKLIST_PHONE = 1;
      USB_BLACKLIST_WWAN = 1;
      USB_AUTOSUSPEND_DISABLE_ON_SHUTDOWN = 1;
      RESTORE_DEVICE_STATE_ON_STARTUP = 0;
      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
      DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
      START_CHARGE_THRESH_BAT0 = 80;
      STOP_CHARGE_THRESH_BAT0 = 100;
    };
  };
}
