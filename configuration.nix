{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  hardware.graphics.enable = true;

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tobi-tower";
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };
  networking.firewall.checkReversePath = false;

  time.timeZone = "Europe/Berlin";

  # services.pulseaudio.enable = true;
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;

  users.users.tobi = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = with pkgs; [
      tree
      spotify
    ];
  };

  users.defaultUserShell = pkgs.zsh; # TODO should be managed by home-manager

  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    cargo
    git
    hyprpaper
    kitty
    networkmanager-openvpn
    networkmanagerapplet
    proton-pass
    protonvpn-gui
    vim
    waybar
    wezterm
    wget
    wireguard-tools
    wofi
  ];

  fonts.packages = with pkgs; [
    monaspace
  ];

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

}
