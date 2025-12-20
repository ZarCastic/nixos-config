{
	description = "Hyprland on NixOS"; 

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		dots.url = "github:ZarCastic/dots";
	};

	outputs = { self, nixpkgs, home-manager, dots,  ...}: {
		nixosConfigurations.tobi-tower = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager 
				{ 
					home-manager = {
						extraSpecialArgs = { inherit dots; };
						useGlobalPkgs = true;
						useUserPackages = true;
						users.tobi = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};
	};

}
