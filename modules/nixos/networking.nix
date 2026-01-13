{ pkgs, username, ... }:
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

  # user default groups
  users = {
    users.${username} = {
      extraGroups = [
        "networkmanager" # required for vpn
      ];
    };
  };
}
