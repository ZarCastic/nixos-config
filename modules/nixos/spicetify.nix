{ spicetify-nix, pkgs, ... }:
{
  imports = [
    spicetify-nix.nixosModules.default
  ];
  programs.spicetify =
    let
      spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };

}
