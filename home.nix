{ nixvim, dots, ... }:

{
  home.username = "tobi";
  home.homeDirectory = "/home/tobi";
  home.stateVersion = "25.11";

  home.packages = [
    nixvim.packages.x86_64-linux.default
  ];

  programs = {
    bat.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    discord.enable = true;
    eza.enable = true;
    bemenu.enable = true;
    fzf.enable = true;
    gcc.enable = true;
    git = {
      enable = true;
      includes = [
        { path = "~/.gitconfig.local"; }
      ];
    };
    lazygit.enable = true;
    obsidian.enable = true;
    ripgrep.enable = true;
    tmux = {
      enable = true;
      extraConfig = builtins.readFile "${dots}/.tmux.conf";
    };
    zsh = {
      enable = true;
      initContent = builtins.readFile "${dots}/zshrc";
      shellAliases = {
        rebuild-system = "sudo nixos-rebuild switch --flake ~/nixos-config";
        upgrade-system = "sudo nixos-rebuild switch --flake ~/nixos-config --upgrade";
      };
    };

  };

  home.file.".p10k.zsh".source = "${dots}/.p10k.zsh";
  xdg.configFile."hypr".source = "${dots}/hypr";
  xdg.configFile."waybar".source = "${dots}/waybar";
  xdg.configFile."tmux/tmux.reset.conf".source = "${dots}/.config/tmux/tmux.reset.conf";
}
