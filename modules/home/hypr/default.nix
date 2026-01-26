{
  pkgs,
  dms,
  lib,
  quickshell,
  ...
}:
let
  workspaces = builtins.concatLists (
    builtins.genList (
      x:
      let
        ws =
          let
            c = (x + 1) / 10;
          in
          builtins.toString (x + 1 - (c * 10));
      in
      [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    ) 10
  );
in
{
  imports = [
    dms.homeModules.dank-material-shell
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    package = pkgs.hyprland;

    settings = {
      binds = {
        allow_workspace_cycles = true;
        workspace_back_and_forth = true;
      };
      decoration = {
        rounding = 10;
        rounding_power = 3;
        blur = {
          enabled = true;
          brightness = 1.0;
          contrast = 1.0;
          noise = 0.01;

          vibrancy = 0.2;
          vibrancy_darkness = 0.5;

          passes = 4;
          size = 7;

          popups = true;
          popups_ignorealpha = 0.2;
        };
      };
      dwindle = {
        pseudotile = true;
        force_split = 2;
        use_active_for_splits = false;
        preserve_split = false;
        smart_split = false;
      };
      master = {
        allow_small_split = true;
        new_status = "inherit";
        orientation = "right";
      };
      input = {
        kb_layout = "eu";
        kb_options = "caps:swapescape";

        # focus change on cursor move
        follow_mouse = 1;
        accel_profile = "flat";
        tablet.output = "current";
        repeat_rate = 35;
        repeat_delay = 200;

        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          clickfinger_behavior = true;
        };
      };
      animations = {
        enabled = true;
        animation = [
          "border, 1, 2, default"
          "fade, 1, 4, default"
          "windows, 1, 3, default, popin 80%"
          "workspaces, 1, 2, default, slide"
        ];
      };
      misc = {
        disable_autoreload = false;
        force_default_wallpaper = 0;
        vrr = 1;
        disable_hyprland_logo = true;
        allow_session_lock_restore = true;
      };
      "$mod" = "SUPER";
      "$terminal" = "footclient";
      "$menu" = "bemenu-run";
      exec-once = [
        "wl-paste --watch cliphist store"
        "udiskie"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 7;
        border_size = 2;
        resize_on_border = false;
        allow_tearing = true;
        layout = "master";
      };
      bind = [
        "$mod SHIFT, E, exit,"
        "$mod SHIFT, Q, killactive,"
        "$mod, V, exec, dms ipc call clipboard toggle"
        "$mod, N, exec, dms ipc call notifications toggle"
        "$mod, o, exec, dms ipc call hypr toggleOverview"
        "$mod, Return, exec, $terminal"
        "$mod, Space, togglefloating,"
        "$mod, D, exec, $menu"
        "$mod, l, movefocus, l"
        "$mod, h, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        "$mod, f, fullscreen,"
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"
        "$mod, r, submap, resize"
        "CTRL ALT, Q, exec, dms ipc call lock lock"
        "$mod SHIFT, code:20, movetoworkspace, special" # bind "SUPER SHIFT -"
        "$mod, code:20, togglespecialworkspace" # bind "SUPER -"
      ]
      ++ workspaces;
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      windowrule = [
        "match:class Spotify, workspace 7"
        "match:class signal, workspace 7"
      ];
      workspace = [
        "special, persistent:true, shadow:true, gapsout:50"
      ];
      env = [
        "QT_QPA_PLATFORM,wayland"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "QT_QPA_PLATFORMTHEME,gtk3"
        "QT_QPA_PLATFORMTHEME_QT6,gtk3"
      ];
    };
    submaps = {
      resize = {
        settings = {
          binde = [
            ", h, resizeactive, -10 0"
            ", l, resizeactive, 10 0"
            ", j, resizeactive, 0 10"
            ", k, resizeactive, 0 -10"
            ", Escape, submap, reset"
          ];
        };
      };
    };
    extraConfig = ''
      source = ~/.config/hypr/dms/*
    '';
  };

  programs = {
    hyprlock = {
      enable = true;
      settings = {
        "$font" = "Monaspace Xenon Var";
        general = {
          hide_cursor = false;
        };

        animations = {
          enabled = true;
          bezier = "linear, 1, 1, 0, 0";

          animation = [
            "fadeIn, 1, 5, linear"
            "fadeOut, 1, 5, linear"
            "inputFieldDots, 1, 2, linear"
          ];
        };

        background = {
          monitor = "";
          path = "screenshot";
          blur_passes = "3";
        };

        input-field = {
          monitor = "";
          size = "20%, 5%";
          outline_thickness = "3";
          inner_color = lib.mkForce "rgba(0, 0, 0, 0.0)"; # no fill

          outer_color = lib.mkForce "rgba(33ccffee) rgba(00ff99ee) 45deg";
          check_color = lib.mkForce "rgba(00ff99ee) rgba(ff6633ee) 120deg";
          fail_color = lib.mkForce "rgba(ff6633ee) rgba(ff0066ee) 40deg";

          font_color = lib.mkForce "rgb(143, 143, 143)";
          fade_on_empty = false;
          rounding = 15;

          font_family = "$font";
          placeholder_text = "Input password...";
          fail_text = "$PAMFAIL";

          dots_spacing = 0.3;

          position = "0, -20";
          halign = "center";
          valign = "center";
        };

        # TIME
        label = [
          {
            monitor = "";
            text = "$TIME";
            font_size = "90";
            font_family = "$font";

            position = "-30, 0";
            halign = "right";
            valign = "top";
          }

          # DATE
          {
            monitor = "";
            text = "cmd[update:60000] date +\"%A, %d %B %Y\""; # update every 60 seconds
            font_size = 25;
            font_family = "$font";

            position = "-30, -150";
            halign = "right";
            valign = "top";
          }
        ];
      };
    };
    dank-material-shell = {
      enable = true;

      systemd = {
        enable = true; # Systemd service for auto-start
        restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
      };

      # Core features
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableClipboardPaste = true; # Clipboard history manager
      enableVPN = true; # VPN management widget
      enableDynamicTheming = false; # Wallpaper-based theming (matugen)
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = true; # Calendar integration (khal)

      quickshell.package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    };
  };

}
