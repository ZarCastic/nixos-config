{
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
      settings = {
        push = {
          autoSetupRemote = true;
        };
        core = {
          editor = "nvim";
        };
      };
    };
    lazygit.enable = true;
    ripgrep.enable = true;
  };
}
