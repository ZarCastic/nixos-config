{ pkgs, stylix, ... }:
{
  imports = [
    stylix.homeModules.stylix
  ];
  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      obsidian = {
        enable = true;
        vaultNames = [ "Notes" ];
      };
      zen-browser = {
        enable = true;
      };
    };
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/ashes.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/banana-blueberry.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/blueish.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/codeschool.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/decaf.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-medium.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/framer.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/jellybeans.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/pnevma.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/porple.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-moon.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/zenburn.yaml";
  };
}
