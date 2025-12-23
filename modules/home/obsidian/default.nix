{ pkgs, ... }:
{

  programs = {
    obsidian = {
      enable = true;
      defaultSettings = {
        themes = [
          {
            pkg = pkgs.callPackage ./catppuccin-theme.nix { };
          }
        ];
        communityPlugins = [
          {
            pkg = pkgs.callPackage ./calendar.nix { };
          }
          {
            pkg = pkgs.callPackage ./git.nix { };
          }
          {
            pkg = pkgs.callPackage ./rollover-daily-todos.nix { };
          }
          {
            pkg = pkgs.callPackage ./simple-todo.nix { };
          }
        ];
      };
      vaults = {
        Notes = {
          enable = true;
        };
      };
    };
  };
}
