{
  config,
  pkgs,
  quickshell,
  dms,
  zen-browser,
  nixvim,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "tobi-tower";

  # nvidia/specifics for tower
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true; # required
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; # only available for newer GPUs
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  # auto mount drives
  services.udisks2.enable = true;

  users.users.tobi = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # allow sudo
      "networkmanager" # required for vpn
    ];
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh; # TODO should be managed by home-manager
  fonts.packages = with pkgs; [
    monaspace
  ];
  environment.pathsToLink = [ "/share/zsh" ]; # for completions

  programs.firefox.enable = true;

  # hypr related
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/tobi";
    quickshell.package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    package = dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableClipboard = true; # Clipboard history manager
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)

    quickshell.package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    package = dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  # gaming
  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  programs.gamemode.enable = true;

  stylix = {
    enable = true;
    autoEnable = true;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/ashes.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/banana-blueberry.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/blueish.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/codeschool.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/decaf.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-medium.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/framer.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/jellybeans.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/pnevma.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/porple.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-moon.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/zenburn.yaml";
  };

  environment.systemPackages = with pkgs; [
    cargo
    git
    hyprpaper
    kitty
    libnotify
    nemo
    networkmanager-openvpn
    networkmanagerapplet
    pavucontrol
    proton-pass
    protonvpn-gui
    signal-desktop
    statix
    alejandra
    nixfmt
    spotify
    tree
    vim
    waybar
    wezterm
    wget
    wireguard-tools
    wofi
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  virtualisation.vmware.host.enable = true;
}
