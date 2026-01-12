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

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nvf,
    # nixvim,
    quickshell,
    dms,
    stylix,
    zen-browser,
    ...
  }: {
    nixosConfigurations.tobi-tower = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit dms;
        inherit zen-browser;
        inherit quickshell;
      };
      modules = [
        ./hosts/tobi-tower/configuration.nix
        ./modules/nixos
        stylix.nixosModules.stylix
        nvf.nixosModules.default
        ./modules/nvf
        # nixvim.homeModules.nixvim
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            # extraSpecialArgs = {
            #   inherit dms;
            # };
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
