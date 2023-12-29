{ config, pkgs, lib, ... }: {
  programs.wofi.enable = true;
  programs.wlogout.enable = true;
  home = { packages = with pkgs; [ swww wl-clipboard ]; };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = true;
    extraConfig = ''
      exec=${pkgs.swww}/bin/swww init;
      exec=${pkgs.swww}/bin/swww img /home/thigo/nixos/home/modules/wallpapers/wallpaper1.gif;
      exec=${pkgs.foot}/bin/foot --server
      exec=${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
      monitor=,preferred,auto,auto


      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = br
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = true
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5
          gaps_out = 10
          border_size = 2
          col.active_border =  rgba(7dcfffff) rgba(7aa2f7ff) 45deg
          col.inactive_border = rgba(595959aa)

          layout = dwindle

      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 10

          blur {
              enabled = true
              size = 3
              passes = 1
          }

          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = true

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # you probably want this
      }

       master {
           See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
           new_is_master = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = true
      }

      misc {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          # force_default_wallpaper = -1 # Set to 0 to disable the anime mascot wallpapers
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      device:epic-mouse-v1 {
          sensitivity = -0.5
      }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Return, exec, ${pkgs.foot}/bin/footclient
      bind = $mainMod, W, exec, ${pkgs.firefox}/bin/firefox
      bind = $mainMod, Q, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, E, exec, thunar
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, R, exec, ${pkgs.wofi}/bin/wofi -I -m -b -a --show drun
      bind = $mainMod, Escape, exec, ${pkgs.wlogout}/bin/wlogout
      bind = $mainMod, P, exec,  ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy
      bind = $mainMod, J, togglesplit, # dwindle

      bind = , XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl -q set 5%+
      bind = , XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -q set 5%-
      bind = , XF86KbdLightOnOff, exec, ${pkgs.brightnessctl}/bin/brightnessctl -q -d dell::kbd_backlight set 1+
      # bind = SHIFT, XF86KbdLightOnOff, exec, ${pkgs.brightnessctl}/bin/brightnessctl -q -d dell::kbd_backlight set 1-

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';
  };
}
