{
  config,
  pkgs,
  dms,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "tobi-tower";

  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; # only available for newer GPUs
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

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
  environment.pathsToLink = [ "/share/zsh" ];

  programs.firefox.enable = true;
  programs.zsh.enable = true;

  # hypr
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
    package = dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  # gaming
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
    pavucontrol
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

}
