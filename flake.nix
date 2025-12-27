{
  description = "Hyprland on NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nvf,
      dms,
      stylix,
      ...
    }:
    {
      nixosConfigurations.tobi-tower = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit dms; };
        modules = [
          ./hosts/tobi-tower/configuration.nix
          ./modules/nixos
          stylix.nixosModules.stylix
          nvf.nixosModules.default
          ./modules/nvf
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {
                inherit dms;
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.tobi = import ./hosts/tobi-tower/home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };

}
