{
  config,
  pkgs,
  zen-browser,
  nixvim,
  stylix,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    stylix.nixosModules.stylix
  ];

  networking.hostName = "tobi-tower";

  # nvidia/specifics for tower
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true; # required
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; # only available for newer GPUs
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  users.defaultUserShell = pkgs.zsh; # TODO should be managed by home-manager
  fonts.packages = with pkgs; [
    monaspace
  ];
  environment.pathsToLink = [ "/share/zsh" ]; # for completions

  # core programs
  programs = {
    firefox.enable = true;
    zsh.enable = true;
  };

  # gaming
  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  programs.gamemode.enable = true;

  stylix = {
    enable = true;
    autoEnable = true;
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

  environment.systemPackages = with pkgs; [
    cargo
    dex
    git
    libnotify # notifications
    nemo # files
    networkmanager-openvpn # vpn
    pavucontrol # sound
    proton-pass # PW Manager
    protonvpn-gui # vpn
    signal-desktop # chat
    statix # editor
    alejandra # editor
    nixfmt # editor
    spotify # music
    tree
    vim
    wget
    wireguard-tools # vpn
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

}
