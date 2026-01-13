{ pkgs, ... }:
{
  networking = {
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };
    firewall.checkReversePath = false;
  };

  environment.systemPackages = with pkgs; [
    networkmanager-openvpn
    wireguard-tools
  ];
}
