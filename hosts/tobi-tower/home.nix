{ pkgs, ... }:
{
  home = {
    username = "tobi";
    homeDirectory = "/home/tobi";
    stateVersion = "25.11";
  };

  home.packages = [
    pkgs.wl-clipboard
  ];

  imports = [
    ./../../modules/home/hypr.nix
    ./../../modules/home/obsidian
    ./../../modules/home/zsh
    ./../../modules/home/tmux
  ];

  programs = {
    bat.enable = true;
    bemenu.enable = true;
    btop.enable = true;
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    discord.enable = true;
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    gcc.enable = true;
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
    git = {
      enable = true;
      includes = [
        { path = "~/.gitconfig.local"; }
      ];
    };
    lazygit.enable = true;
    ripgrep.enable = true;
  };

  services = {
    cliphist.enable = true;
    flameshot = {
      enable = true;
      settings = {
        General = {
          showStartupLaunchMessage = false;
          useGrimAdapter = true;
          disabledGrimWarning = true;
        };
      };
    };

    udiskie = {
      enable = true;
      settings = {
        program_options = {
          file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
        };
      };
    };
  };
}
