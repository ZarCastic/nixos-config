{ pkgs, ... }:
{
  imports = [
    ./hypr.nix
    ./stylix.nix
  ];

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

  # auto mount drives
  services.udisks2.enable = true;

  # user default groups
  users = {
    users.tobi = {
      isNormalUser = true;
      extraGroups = [
        "wheel" # allow sudo
        "networkmanager" # required for vpn
        "vboxusers" # virtualbox
      ];
    };
    defaultUserShell = pkgs.zsh;
  };
  fonts.packages = with pkgs; [
    monaspace
  ];
  environment.pathsToLink = [ "/share/zsh" ]; # for completions

  services.gnome.gnome-keyring.enable = true;

  virtualisation.vmware.host.enable = true;
  virtualisation.virtualbox = {
    host.enable = true;
    guest = {
      enable = true;
      dragAndDrop = true;
    };
  };

  environment.systemPackages = with pkgs; [
    libnotify
    nemo
    networkmanager-openvpn
    pavucontrol
    wireguard-tools
  ];

  # never change
  system.stateVersion = "25.11";
}
