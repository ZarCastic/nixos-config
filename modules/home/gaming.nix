{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class discord, workspace 2"
      "match:class steam, workspace 6"
      "match:class steam_app_0, workspace 5"
    ];
  };
  programs = {
    discord.enable = true;
  };
}
