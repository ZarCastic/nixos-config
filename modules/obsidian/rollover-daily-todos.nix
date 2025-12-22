{
  pkgs,
  ...
}:

let
  pnpm_compat = pkgs.pnpm_8;
in
pkgs.stdenv.mkDerivation rec {
  pname = "obsidian.plugins.rollover-daily-todos";
  version = "1.2.0";
  src = pkgs.fetchFromGitHub {
    owner = "lumoe";
    repo = "obsidian-rollover-daily-todos";
    rev = version;
    hash = "sha256-/r++FPIMRAmFrbxpCv02RDvHU3USaAa6MgQxR8RK1lQ=";
  };

  patches = [ ./rollover-daily-todos.patch ];

  pnpmDeps = pkgs.fetchPnpmDeps {
    version = version;
    src = src;
    pname = pname;
    fetcherVersion = 3;
    hash = "sha256-hXZWQ4LrIqebLL73uv+DX3lnKbHCTuSLfk79RNXIwAo=";
    patches = [ ./rollover-daily-todos.patch ];
    pnpm = pnpm_compat;
  };

  buildPhase = ''
    runHook preBuild
    pnpm run build
    runHook postBuild
  '';

  nativeBuildInputs = with pkgs; [
    nodejs
    pnpmConfigHook
    pnpm_compat
    npmHooks.npmInstallHook
  ];

  installPhase = ''
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./main.js $out/main.js
  '';
}
