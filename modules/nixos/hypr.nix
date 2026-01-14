{
  pkgs,
  dms,
  quickshell,
  username,
  ...
}:
{
  imports = [
    dms.nixosModules.dank-material-shell
    dms.nixosModules.greeter
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  security.pam.services.hyprland.enableGnomeKeyring = true;
  # services.displayManager.dms-greeter = {
  #   enable = true;
  #   compositor.name = "hyprland";
  #   configHome = "/home/${username}";
  #
  #   quickshell.package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  #   package = dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
  # };
  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/${username}";

    quickshell.package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
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
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)

    quickshell.package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };
}
