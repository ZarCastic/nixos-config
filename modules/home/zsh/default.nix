{lib, ...}: let
  aliases = import ./aliases.nix;
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      strategy = ["match_prev_cmd"];
    };
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
      extended = true;
      share = true;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      findNoDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      saveNoDups = true;
    };
    historySubstringSearch.enable = true;
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
