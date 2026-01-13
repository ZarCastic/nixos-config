{
  config,
  pkgs,
  zen-browser,
  nixvim,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
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

  # core programs
  programs = {
    firefox.enable = true;
    zsh.enable = true;
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

  environment.systemPackages = with pkgs; [
    cargo
    dex
    git
    proton-pass # PW Manager
    protonvpn-gui # vpn
    signal-desktop # chat
    statix # nix lint editor
    alejandra # nix lint editor
    nixfmt # editor
    spotify # music
    tree
    vim
    wget
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default # -> home-manager
    nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

}
