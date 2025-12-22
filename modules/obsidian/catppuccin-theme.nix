{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian.themes.catppuccin";
  version = "main";
  src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "obsidian";
    rev = version;
    hash = "sha256-sN5k263geOtJ1mOCQGM8UdmA/71OhBI5NRwGxJwd80E=";
  };

  installPhase = ''
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./theme.css $out/theme.css
  '';
}
