{
  pkgs,
  dms,
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
        disable_autoreload = true;
        force_default_wallpaper = 0;
        vrr = 1;
      };
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
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
        "$mod, b, exec, zen-twilight"
      ]
      ++ workspaces;
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      windowrule = [
        "match:class Spotify, workspace 7"
      ];
      workspace = [
        "special, persistent:true, shadow:true, gapsout:50"
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
  };

  programs.dank-material-shell = {
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

}
