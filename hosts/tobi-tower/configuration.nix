{
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/nixos/gaming.nix
  ];

  networking.hostName = "tobi-tower";

  # nvidia/specifics for tower
  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true; # required
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false; # only available for newer GPUs
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

}
