{ username, ... }:
{
  virtualisation.vmware.host.enable = true;
  virtualisation.virtualbox = {
    host.enable = true;
  };

  users = {
    users.${username} = {
      extraGroups = [
        "vboxusers"
      ];
    };
  };
}
