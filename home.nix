{config, pkgs, ...}:

{
	home.username = "tobi";
	home.homeDirectory = "/home/tobi";
	home.stateVersion = "25.11";
	programs.zsh = { 
		enable = true;
		profileExtra = ''
			if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then 
				exec hyprland
			fi
		'';
	};

	programs.git = { 
		enable = true;
		includes = [
			{ path = "~/.gitconfig.local"; }
		];
	};
}
