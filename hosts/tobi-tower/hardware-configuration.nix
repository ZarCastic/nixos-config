{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/ROOT";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/HOME";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/home/tobi/projects" = {
    device = "/dev/disk/by-label/PROJECTS";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/home/tobi/games" = {
    device = "/dev/disk/by-label/GAMES";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/home/tobi/data" = {
    device = "/dev/disk/by-label/DataDisk";
    fsType = "ntfs";
    options = [ "nofail" ];
  };

  systemd.tmpfiles.rules = [
    "d /home/tobi/projects 0755 tobi users -"
    "d /home/tobi/games 0755 tobi users -"
    "d /home/tobi/data 0755 tobi users -"
  ];

  swapDevices = [
    { device = "/dev/disk/by-uuid/665d3a28-9be3-44f8-811e-f4d81c7dd471"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
