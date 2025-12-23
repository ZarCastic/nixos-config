{
  description = "Hyprland on NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:dc-tec/nixvim";

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dots.url = "github:ZarCastic/dots";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      dms,
      dots,
      ...
    }:
    {
      nixosConfigurations.tobi-tower = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit dms; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {
                inherit dots;
                inherit nixvim;
                inherit dms;
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
