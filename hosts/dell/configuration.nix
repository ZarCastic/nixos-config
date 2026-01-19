{
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
}
