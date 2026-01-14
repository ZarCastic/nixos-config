{ pkgs, ... }:
{
  services = {
    # clipboard history
    cliphist.enable = true;

    # screenshots
    flameshot = {
      enable = true;
      settings = {
        General = {
          showStartupLaunchMessage = false;
          useGrimAdapter = true;
          disabledGrimWarning = true;
        };
      };
    };

    # auto mount disks
    udiskie = {
      enable = true;
      settings = {
        program_options = {
          file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
        };
      };
    };

    # monitor management
    kanshi = {
      enable = true;
      systemdTarget = "hyprland-session.target";
    };
  };
}
