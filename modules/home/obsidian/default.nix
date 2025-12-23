{ pkgs, ... }:
{

  programs = {
    obsidian = {
      enable = true;
      defaultSettings = {
        appearance = {
          theme = "obsidian";
        };
        themes = [
          {
            pkg = pkgs.callPackage ./catppuccin-theme.nix { };
          }
        ];
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
