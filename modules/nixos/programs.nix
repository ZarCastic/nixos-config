{
  nixvim,
  pkgs,
  zen-browser,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    alejandra # nix lint editor
    cargo
    dex
    git
    libnotify
    nemo
    nixfmt # editor
    nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
    pavucontrol
    proton-pass # PW Manager
    signal-desktop # chat
    spotify # music
    statix # nix lint editor
    tree
    usbutils
    vim
    wget
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default # -> home-manager
  ];

  # core programs
  programs = {
    firefox.enable = true;
    zsh.enable = true;
  };
}
