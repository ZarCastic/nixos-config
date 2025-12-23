{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian.plugins.calendar";
  version = "1.5.10";
  src = pkgs.fetchFromGitHub {
    owner = "liamcain";
    repo = "obsidian-calendar-plugin";
    rev = version;
    hash = "sha256-SQtr2ZI5MecyNYS40okR+uEirww4GZz9WmQObv7ffNc=";
  };

  offlineCache = pkgs.fetchYarnDeps {
    yarnLock = src + "/yarn.lock";
    hash = "sha256-YvJbiMU+1tQ6V9MCiICCxaShvDfCNtXy0AqOt73vCz0=";
  };

  nativeBuildInputs = with pkgs; [
    nodejs
    yarnConfigHook
    yarnBuildHook
    npmHooks.npmInstallHook
  ];

  installPhase = ''
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./main.js $out/main.js
    cp ./styles.css $out/styles.css
  '';
}
