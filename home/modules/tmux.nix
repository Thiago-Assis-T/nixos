{ config, pkgs, lib, ... }: {
  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    clock24 = true;
    keyMode = "vi";
    newSession = true;
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = online-status;
        extraConfig = ''
          set -g status-left 'Net #{online_status} [#{session_name}]'
        '';

      }
      {
        plugin = cpu;
        extraConfig = ''
          set -g @cpu_temp_unit "C"
          set -g status-right 'CPU #{cpu_percentage} | Mem #{ram_percentage} | %a %H:%M '
        '';
      }
    ];
    extraConfig = ''
      set-option -g status-justify centre
      set-option -g status-bg blue
      set-option -g status-right-bg blue
      set-option -g status-left-length 30
      set-option -sa terminal-overrides ",xterm*:Tc"
      bind-key r source-file ~/.config/tmux/tmux.conf\; display-message "config reloaded."
    '';
  };

}
