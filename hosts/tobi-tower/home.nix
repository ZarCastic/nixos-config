{
  pkgs,
  nixvim,
  dots,
  ...
}:

{
  home.username = "tobi";
  home.homeDirectory = "/home/tobi";
  home.stateVersion = "25.11";

  home.packages = [
    nixvim.packages.x86_64-linux.default
    pkgs.wl-clipboard
  ];

  imports = [
    # ./../../modules/home/common.nix
    ./../../modules/home/hypr.nix
    ./../../modules/home/obsidian
  ];

  programs = {
    bat.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    eza.enable = true;
    fzf.enable = true;
    gcc.enable = true;
    ghostty = {
      enable = true;
      package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = false;
      settings = {
        theme = "Catppuccin Macchiato";
        font-family = "Monaspace Xenon Var";
        font-feature = "liga,ss01,ss02,ss03,ss04";
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
    tmux = {
      enable = true;
      extraConfig = builtins.readFile "${dots}/.tmux.conf";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };
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
      shellAliases = {
        k = "exit";
        rebuild-system = "sudo nixos-rebuild switch --flake ~/nixos-config";
        upgrade-system = "sudo nixos-rebuild switch --flake ~/nixos-config --upgrade";
        nix-search = "nix --extra-experimental-features \"nix-command flakes\" search nixpkgs";
      };
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

  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    cursorTheme = {
      name = "Catppuccin-Macchiato-Blue";
      package = pkgs.catppuccin-cursors.macchiatoBlue;
    };

    theme = {
      name = "Catppuccin-Macchiato-Compact-Blue-dark";
      package = pkgs.catppuccin-gtk.override {
        size = "compact";
        accents = [ "blue" ];
        variant = "macchiato";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-folders;
    };
  };

  xdg.configFile."tmux/tmux.reset.conf".source = "${dots}/.config/tmux/tmux.reset.conf";
}
