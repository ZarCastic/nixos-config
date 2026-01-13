{ pkgs, ... }:
{
  # gaming
  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  programs.gamemode.enable = true;
}
