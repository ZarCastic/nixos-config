{
  pkgs,
  ...
}:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian.plugins.obsidian-git";
  version = "2.35.2";
  src = pkgs.fetchFromGitHub {
    owner = "Vinzent03";
    repo = "obsidian-git";
    rev = version;
    hash = "sha256-A3s9+fhHRc6YC/YObJWqIG8NfA638gMkmjQtoOifO8s=";
  };

  pnpmDeps = pkgs.fetchPnpmDeps {
    version = version;
    src = src;
    pname = pname;
    fetcherVersion = 3;
    hash = "sha256-y+7ZlzpOlgzkSFkzDKFlD/RxaK3WbssQgIxf36oE63I=";
  };

  buildPhase = ''
    runHook preBuild 
    pnpm run build
    runHook postBuild
  '';

  nativeBuildInputs = with pkgs; [
    nodejs
    pnpmConfigHook
    typescript
    pnpm
    npmHooks.npmInstallHook
  ];

  installPhase = ''
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./main.js $out/main.js
    cp ./styles.css $out/styles.css
  '';
}
