# SPDX-FileCopyrightText: © 2026 Jeffrey C. Ollie
# SPDX-License-Identifier: MIT

{
  inputs = {
    nixpkgs = {
      url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    };
    zig = {
      url = "git+https://git.ocjtech.us/jeff/zig-overlay.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      zig,
      ...
    }:
    let
      packages =
        system:
        import nixpkgs {
          inherit system;
        };
      forAllSystems = (
        function:
        nixpkgs.lib.genAttrs [
          "aarch64-linux"
          "x86_64-linux"
        ] (system: function (packages system))
      );
    in
    {
      devShells = forAllSystems (pkgs: {
        name = "sfnt2woff";
        master = pkgs.mkShell {
          name = "sfnt2woff";
          nativeBuildInputs = [
            zig.packages.${pkgs.stdenv.hostPlatform.system}.master
            pkgs.reuse
          ];
          buildInputs = [
            pkgs.zlib
          ];
        };
        default = self.devShells.${pkgs.stdenv.hostPlatform.system}.master;
      });
    };
}
