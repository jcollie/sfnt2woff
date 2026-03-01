{
  pkgs,
  zig,
  libz,
  pkg-config,
  ...
}:
pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "sfnt2woff";
  version = "0.0.1";
  src = pkgs.lib.cleanSource ./.;
  nativeBuildInputs = [
    zig
    pkg-config
  ];
  buildInputs = [
    libz
  ];
})
