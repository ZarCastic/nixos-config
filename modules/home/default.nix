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
    ./zsh
    ./tmux.nix
    ./terminal.nix
    ./programs.nix
    ./services.nix
    ./stylix.nix
  ];
}
