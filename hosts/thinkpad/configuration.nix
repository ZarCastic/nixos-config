{
  hostname,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/nixos/bluetooth.nix
  ];

  boot.initrd.luks.devices."luks-7523f139-ce39-4d41-9c81-2279bc723855".device =
    "/dev/disk/by-uuid/7523f139-ce39-4d41-9c81-2279bc723855";

  networking.hostName = "${hostname}";
}
