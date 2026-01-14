{
  description = "ZarCastic NixOs";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
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

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:ZarCastic/NixVim";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      quickshell,
      dms,
      stylix,
      nixvim,
      zen-browser,
      ...
    }:

    {
      nixosConfigurations = {
        "tobi-tower" =
          with {
            username = "tobi";
            hostname = "tobi-tower";
          };
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit dms;
              inherit zen-browser;
              inherit quickshell;
              inherit nixvim;
              inherit stylix;
              inherit username;
              inherit hostname;
            };
            modules = [
              ./hosts/tower/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${username} = import ./hosts/tower/home.nix;
                  extraSpecialArgs = { inherit username; };
                  backupFileExtension = "backup";
                };
              }
            ];
          };

        "tobi-work" =
          with {
            username = "tobi";
            hostname = "tobi-work";
          };
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit dms;
              inherit zen-browser;
              inherit quickshell;
              inherit nixvim;
              inherit stylix;
              inherit username;
              inherit hostname;
            };
            modules = [
              ./hosts/work/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${username} = import ./hosts/work/home.nix;
                  extraSpecialArgs = { inherit username; };
                  backupFileExtension = "backup";
                };
              }
            ];
          };
      };
    };
}
