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
    # use ~/.config/kanshi/config for configuration - should be system specific
    # e.g.
    # output "BNQ BenQ XL2720Z P1F00314SL0" {
    #   mode "1920x1080@144.00Hz"
    #   position 0,0
    #   scale 1
    #   alias $DESKTOP
    # }
    #
    # profile desktop {
    #   output $DESKTOP enable
    # }
    kanshi = {
      enable = true;
      systemdTarget = "hyprland-session.target";
    };
  };
}
