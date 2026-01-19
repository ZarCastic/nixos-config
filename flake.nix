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
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
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
      firefox-addons,
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
                    inherit zen-browser;
                    inherit firefox-addons;
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
                    inherit firefox-addons;
                    inherit quickshell;
                    inherit zen-browser;
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
                    inherit dms;
                    inherit stylix;
                    inherit firefox-addons;
                    inherit quickshell;
                    inherit zen-browser;
                  };
                  backupFileExtension = "backup";
                };
              }
            ];
          };

        "LW-00001" =
          with {
            username = "tobi";
            hostname = "LW-00001";
          };
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit dms;
              inherit nixvim;
              inherit username;
              inherit hostname;
              inherit quickshell;
              inherit spicetify-nix;
            };
            modules = [
              ./hosts/dell/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${username} = import ./hosts/dell/home.nix;
                  extraSpecialArgs = {
                    inherit username;
                    inherit dms;
                    inherit stylix;
                    inherit firefox-addons;
                    inherit quickshell;
                    inherit zen-browser;
                  };
                  backupFileExtension = "backup";
                };
              }
            ];
          };
      };
    };
}
