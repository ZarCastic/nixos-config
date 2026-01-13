{
  pkgs,
  nixvim,
  zen-browser,
  username,
  ...
}:
{
  imports = [
    ./hypr.nix
    ./stylix.nix
    ./networking.nix
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

  # user default groups
  users = {
    users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel" # allow sudo
        "networkmanager" # required for vpn
        "vboxusers" # virtualbox
      ];
    };
    defaultUserShell = pkgs.zsh;
  };
  fonts.packages = with pkgs; [
    monaspace
  ];
  environment.pathsToLink = [ "/share/zsh" ]; # for completions

  virtualisation.vmware.host.enable = true;
  virtualisation.virtualbox = {
    host.enable = true;
    guest = {
      enable = true;
      dragAndDrop = true;
    };
  };

  environment.systemPackages = with pkgs; [
    libnotify
    nemo
    pavucontrol
    cargo
    dex
    git
    proton-pass # PW Manager
    protonvpn-gui # vpn # -> private
    signal-desktop # chat
    statix # nix lint editor
    alejandra # nix lint editor
    nixfmt # editor
    spotify # music
    tree
    vim
    wget
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default # -> home-manager
    nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # core programs
  programs = {
    firefox.enable = true;
    zsh.enable = true;
  };

  services = {
    # auto mount drives
    udisks2.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  # never change
  system.stateVersion = "25.11";
}
