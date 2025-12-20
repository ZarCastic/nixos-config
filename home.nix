{config, pkgs, dots, ...}:

{
	home.username = "tobi";
	home.homeDirectory = "/home/tobi";
	home.stateVersion = "25.11";
	programs.zsh = { 
		enable = true;
		initContent = builtins.readFile "${dots}/zshrc";
	};

	programs.bat.enable = true;
	programs.eza.enable = true;
	programs.direnv = { 
		enable = true; 
		enableZshIntegration = true;
	};
	programs.fzf.enable = true; 
	programs.ripgrep.enable = true;
	programs.tmux = { 
		enable = true;
		extraConfig = builtins.readFile "${dots}/.tmux.conf";
	};
	programs.git = { 
		enable = true;
		includes = [
			{ path = "~/.gitconfig.local"; }
		];
	};



	home.file.".p10k.zsh".source = "${dots}/.p10k.zsh";
	xdg.configFile."hypr".source = "${dots}/hypr";
	xdg.configFile."waybar".source = "${dots}/waybar";
	xdg.configFile."tmux/tmux.reset.conf".source = "${dots}/.config/tmux/tmux.reset.conf";
}
