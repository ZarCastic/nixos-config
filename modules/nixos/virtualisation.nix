{ username, ... }:
{
  virtualisation.vmware.host.enable = true;
  virtualisation.virtualbox = {
    host.enable = true;
    guest = {
      enable = true;
      dragAndDrop = true;
    };
  };

  users = {
    users.${username} = {
      extraGroups = [
        "vboxusers"
      ];
    };
  };
}
