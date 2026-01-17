{
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./hypr.nix
    ./networking.nix
    ./virtualisation.nix
    ./programs.nix
    ./spicetify.nix
    ./zen-browser.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      #   interval = { Weekday = 0; Hour = 0; Minute = 0; }; # for darwin
      options = "--delete-older-than 30d";
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Europe/Berlin";

  # principal user setup
  users = {
    users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
      ];
    };
    defaultUserShell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    monaspace
  ];

  environment.pathsToLink = [ "/share/zsh" ]; # for completions

  services = {
    udisks2.enable = true; # auto mount drives
    gnome.gnome-keyring.enable = true;
  };

  system.stateVersion = "25.11"; # never change
}
