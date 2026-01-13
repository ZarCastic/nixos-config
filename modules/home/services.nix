{ pkgs, ... }:
{
  services = {
    cliphist.enable = true;
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

    udiskie = {
      enable = true;
      settings = {
        program_options = {
          file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
        };
      };
    };
  };
}
