{
  pkgs,
  dms,
  username,
  quickshell,
  ...
}:
{
  imports = [
    dms.nixosModules.greeter
  ];
  security.pam.services.hyprland.enableGnomeKeyring = true;

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    dank-material-shell.greeter = {
      enable = true;
      compositor.name = "hyprland";
      configHome = "/home/${username}";
      quickshell.package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    };
  };
}
