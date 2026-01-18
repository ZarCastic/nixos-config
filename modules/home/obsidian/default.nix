{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace special silent] obsidian"
    ];
    windowrule = [
      "match:class obsidian, workspace special"
    ];
  };

  programs = {
    obsidian = {
      enable = true;
      defaultSettings = {
        corePlugins = [
          "backlink"
          "bases"
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
        app = {
          "attachmentFolderPath" = "Attachments";
          "alwaysUpdateLinks" = true;
        };
        hotkeys = {
          zk-prefixer = [
            {
              modifiers = [ "Alt" ];
              key = "N";
            }
          ];
          insert-template = [
            {
              modifiers = [ "Alt" ];
              key = "T";
            }
          ];
        };
      };
      vaults = {
        Notes = {
          enable = true;
        };
      };
    };
  };
}
