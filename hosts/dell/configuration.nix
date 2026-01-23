{
  pkgs,
  hostname,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/powermanagement.nix
  ];

  boot.initrd.luks.devices."luks-5d12f2b1-766f-45a6-847c-ad23b23cbedc".device =
    "/dev/disk/by-uuid/5d12f2b1-766f-45a6-847c-ad23b23cbedc";

  networking.hostName = "${hostname}";

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    graphics = {
      enable = true;
    };
    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = true; # turing and later, we are on ada-lovelace
      nvidiaSettings = true;

      prime = {
        offload = {
          enable = true; # we use sync mode for now
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    thunderbird
  ];
}
