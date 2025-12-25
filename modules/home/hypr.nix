{ pkgs, dms, ... }:

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
    dms.homeModules.dankMaterialShell.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    package = pkgs.hyprland;

    settings = {
      "monitor" = "DP-2,1920x1080@144.00Hz,auto,1";
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
        preserve_split = true;
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
        "protonvpn-app"
        "proton-pass"
        "wl-paste --watch cliphist store"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 7;
        border_size = 2;
        resize_on_border = false;
        allow_tearing = true;
        layout = "dwindle";
      };
      bind = [
        "$mod SHIFT, E, exit,"
        "$mod SHIFT, Q, killactive,"
        "$mod, V, exec, cliphist list | wofi --dmenu --pre-display-cmd \"echo '%s' | cut -f 2\" | cliphist decode | wl-copy"
        "$mod, Return, exec, $terminal"
        "$mod, Space, togglefloating,"
        "$mod, D, exec, $menu"
        "$mod, l, movefocus, l"
        "$mod, h, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
      ]
      ++ workspaces;
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };

  programs = {
    dankMaterialShell = {
      enable = true;
      default.settings = {
        systemd = {
          enable = true;
          restartIfChanged = true;
        };
        systemMonitoring = true;
        clipboard = true;
        VPN = true;
        dynamicTheming = false;
        audioWavelength = true;
        calendarEvents = true;
      };
    };
    discord.enable = true;
    bemenu.enable = true;
  };
}
