{
  description = "ZarCastic NixOs";

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

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nixvim.url = "github:ZarCastic/NixVim";
  };

  outputs =
    {
      dms,
      home-manager,
      nixpkgs,
      nixvim,
      quickshell,
      spicetify-nix,
      stylix,
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
              inherit nixvim;
              inherit username;
              inherit hostname;
              inherit quickshell;
              inherit spicetify-nix;
            };
            modules = [
              ./hosts/tower/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${username} = import ./hosts/tower/home.nix;
                  extraSpecialArgs = {
                    inherit username;
                    inherit dms;
                    inherit quickshell;
                    inherit stylix;
                  };
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
              inherit nixvim;
              inherit username;
              inherit hostname;
              inherit quickshell;
              inherit spicetify-nix;
            };
            modules = [
              ./hosts/work/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${username} = import ./hosts/work/home.nix;
                  extraSpecialArgs = {
                    inherit username;
                    inherit dms;
                    inherit stylix;
                    inherit quickshell;
                  };
                  backupFileExtension = "backup";
                };
              }
            ];
          };

        "tobi-thinkpad" =
          with {
            username = "tobi";
            hostname = "tobi-thinkpad";
          };
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit dms;
              inherit zen-browser;
              inherit nixvim;
              inherit username;
              inherit hostname;
              inherit quickshell;
              inherit spicetify-nix;
            };
            modules = [
              ./hosts/thinkpad/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${username} = import ./hosts/thinkpad/home.nix;
                  extraSpecialArgs = {
                    inherit username;
                    inherit stylix;
                    inherit dms;
                    inherit quickshell;
                  };
                  backupFileExtension = "backup";
                };
              }
            ];
          };
      };
    };
}
