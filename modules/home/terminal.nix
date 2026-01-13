{ pkgs, ... }:
{
  programs = {
    ghostty = {
      enable = true;
      package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = false;
      settings = {
        font-family = "Monaspace Xenon Var";
        font-feature = "liga,ss01,ss02,ss03,ss04,ss05,ss06,ss07,ss08,ss09,ss10";
      };
    };
  };
}
