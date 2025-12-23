{ pkgs, ... }:

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

        shadow = {
          enabled = true;
          color = "rgba(00000055)";
          ignore_window = true;
          offset = "0 15";
          range = 100;
          render_power = 2;
          scale = 0.97;
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
      "$terminal" = "wezterm";
      "$menu" = "bemenu-run";
      exec-once = [
        "nm-applet"
        "protonvpn-app"
        "proton-pass"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 7;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = true;
        layout = "dwindle";
      };
      bind = [
        "$mod SHIFT, E, exit,"
        "$mod SHIFT, Q, killactive,"
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
}
