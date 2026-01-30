{
  lib,
  config,
  ...
}:
let
  aliases = import ./aliases.nix;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = true;
    autocd = true;
    dotDir = "${config.xdg.configHome}/zsh";

    cdpath = [
      "$HOME"
      "$HOME/projects"
    ];
    envExtra = ''
      [ -f ${config.xdg.configHome}/zsh/environment ] && source ${config.xdg.configHome}/zsh/environment
      [ -z flk ] && eval "$(flk hook zsh)"
    '';
    sessionVariables = {
      PATH = "$PATH:$HOME/.cargo/bin:$HOME/go/bin:$HOME/Scripts:$HOME/bin";
      EDITOR = "nvim";
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
    prezto = {
      enable = true;
      pmodules = [
        "history-substring-search"
        "autosuggestions"
        "environment"
        "terminal"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
      ];
      utility.safeOps = false;
    };
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
