{
  pkgs,
  nixvim,
  zen-browser,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    libnotify
    nemo
    pavucontrol
    cargo
    dex
    git
    proton-pass # PW Manager
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

  # core programs
  programs = {
    firefox.enable = true;
    zsh.enable = true;
  };
}
