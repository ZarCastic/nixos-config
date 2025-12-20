{config, pkgs, ...}:

{
	home.username = "tobi";
	home.homeDirectory = "/home/tobi";
	home.stateVersion = "25.11";
	programs.zsh = { 
		enable = true;
	};

	programs.git = { 
		enable = true;
		includes = [
			{ path = "~/.gitconfig.local"; }
		];
	};

	home.file.".config/hypr".source = "${dots}/hypr";
	home.file.".config/waybar".source = "${dots}/waybar";
}
