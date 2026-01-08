{lib, ...}: let
  aliases = import ./aliases.nix;
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    cdpath = [
      "$HOME"
      "$HOME/projects"
    ];
    sessionVariables = {
      PATH = "$PATH:$HOME/Scripts:$HOME/bin";
    };
    history = {
      append = true;
      share = true;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      findNoDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      saveNoDups = true;
    };
    siteFunctions = {
      mkcd = ''
        mkdir -p "$1" && cd "$1"
      '';
    };
    shellAliases = lib.mergeAttrsList [
      aliases.git_aliases
      aliases.nixos_aliases
      aliases.sanity_aliases
    ];
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
