{
  pkgs,
  lib,
  dots,
  ...
}:
let
  aliases = import ./aliases.nix;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    cdpath = [
      "$HOME"
      "$HOME/Projects"
    ];
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

    plugins = [
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = "${dots}";
        file = ".p10k.zsh";
      }
    ];
  };
}
