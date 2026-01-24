{ pkgs, username, ... }:
{
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
    packages = [
      pkgs.wl-clipboard
    ];
  };

  imports = [
    ./hypr
    ./obsidian
    ./programs.nix
    ./services.nix
    ./stylix.nix
    ./tmux.nix
    ./zen-browser.nix
    ./zsh
  ];
}
