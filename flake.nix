{
  description = "ZarCastic NixOs";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
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
    let
      username = "tobi";
    in
    {
      nixosConfigurations.tobi-tower = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit dms;
          inherit zen-browser;
          inherit quickshell;
          inherit nixvim;
          inherit stylix;
          inherit username;
        };
        modules = [
          ./hosts/tobi-tower/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./hosts/tobi-tower/home.nix;
              extraSpecialArgs = { inherit username; };
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}
