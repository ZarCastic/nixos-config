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

  users.users.tobi = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # allow sudo
      "networkmanager" # required for vpn
    ];
  };

  users.defaultUserShell = pkgs.zsh; # TODO should be managed by home-manager
  environment.pathsToLink = [ "/share/zsh" ]; # for completions

  programs.firefox.enable = true;
  programs.zsh.enable = true;

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
    spotify
    tree
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
