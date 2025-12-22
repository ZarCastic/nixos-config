{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian.plugins.simple-todo";
  version = "0.2.7";
  src = pkgs.fetchFromGitHub {
    owner = "elliotxx";
    repo = "obsidian-simple-todo";
    rev = version;
    hash = "sha256-dUfOhYwJLt2jzOXskWUCmeBf1UTzqYQfJwkTGUp1AHQ=";
  };

  npmDeps = pkgs.fetchNpmDeps {
    version = version;
    src = src;
    pname = pname;
    hash = "sha256-8Sj/73jWteZ15uM/0zwtEHIHDGaU1BucMjoICM4GEHM=";
  };

  npmBuildScript = "build";

  nativeBuildInputs = with pkgs; [
    nodejs
    typescript
    npmHooks.npmConfigHook
    npmHooks.npmBuildHook
    npmHooks.npmInstallHook
  ];

  installPhase = ''
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./main.js $out/main.js
    cp ./styles.css $out/styles.css
  '';
}
