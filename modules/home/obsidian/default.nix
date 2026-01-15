{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace special silent] obsidian"
    ];
  };

  programs = {
    obsidian = {
      enable = true;
      defaultSettings = {
        corePlugins = [
          "backlink"
          "bookmarks"
          "canvas"
          "command-palette"
          "daily-notes"
          "editor-status"
          "file-explorer"
          "file-recovery"
          "global-search"
          "graph"
          "markdown-importer"
          "note-composer"
          "outgoing-link"
          "outline"
          "page-preview"
          "properties"
          "random-note"
          "slash-command"
          "slides"
          "switcher"
          "sync"
          "tag-pane"
          "templates"
          "word-count"
          "workspaces"
          "zk-prefixer"
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
