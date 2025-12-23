{ pkgs, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    #   interval = { Weekday = 0; Hour = 0; Minute = 0; }; # for darwin
    options = "--delete-older-than 30d";
  };

  # never change
  system.stateVersion = "25.11";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };
  networking.firewall.checkReversePath = false;

  time.timeZone = "Europe/Berlin";
}
