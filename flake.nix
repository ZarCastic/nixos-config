{
  description = "Hyprland on NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:dc-tec/nixvim";

    dots.url = "github:ZarCastic/dots";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixvim,
      dots,
      ...
    }:
    {
      nixosConfigurations.tobi-tower = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {
                inherit dots;
                inherit nixvim;
              };
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
