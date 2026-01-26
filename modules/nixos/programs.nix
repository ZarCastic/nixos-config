{
  nixvim,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    alejandra # nix lint editor
    cargo
    dex
    git
    keymapp
    libnotify
    nemo
    nixfmt # editor
    nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
    pavucontrol
    proton-pass # PW Manager
    signal-desktop # chat
    spotify # music
    statix # nix lint editor
    swaylock
    tree
    usbutils
    vim
    vivaldi
    wget
  ];

  # core programs
  programs = {
    zsh.enable = true;
    chromium = {
      enable = true;
      extraOpts = {
        "ExtensionInstallForcelist" = [
          # uBlock Origin lite
          "ddkjiahejlhfcafbddmgiahcphecmpfh;https://clients2.google.com/service/update2/crx"
          # Bitwarden
          "nngceckbapebfimnlniiiahkandclblb;https://clients2.google.com/service/update2/crx"
          # proton pass
          "ghmbeldphafepmbegfdlkpapadhbakde;https://clients2.google.com/service/update2/crx"
          # vimium
          "dbepggeogbaibhgnhhndojpepiihcmeb;https://clients2.google.com/service/update2/crx"
        ];
      };
    };
  };
}
