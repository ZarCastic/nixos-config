{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class discord, workspace 2"
      "match:class steam, workspace 6"
    ];
  };
  programs = {
    discord.enable = true;
  };
}
