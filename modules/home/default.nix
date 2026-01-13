{ pkgs, username, ... }:
{
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
    packages = [
      pkgs.wl-clipboard
    ];
  };

  imports = [
    ./hypr.nix
    ./obsidian
    ./zsh
    ./tmux.nix
    ./terminal.nix
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
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    gcc.enable = true;
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
