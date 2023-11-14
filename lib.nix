{
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs) lib;
  typst-packages = pkgs.linkFarm "typst" [
    {
      name = "typst";
      path = "${inputs.typst-packages}";
    }
  ];
in {
  _module.args.pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [inputs.typst.overlays.default];
  };
  flake.lib = {
    buildTypstDoc = src: fonts: name: let
      fontsConf = pkgs.symlinkJoin {
        name = "typst-fonts";
        paths = fonts;
      };
    in
      pkgs.stdenv.mkDerivation {
        name = "Test Docs";
        inherit src;
        buildInputs = with pkgs; [typst-dev];

        buildPhase = ''
          XDG_CACHE_HOME=${typst-packages} ${lib.getExe pkgs.typst-dev} compile --font-path ${fontsConf} main.typ ${name}-docs.pdf
        '';

        installPhase =
          /*
          bash
          */
          ''
            mkdir -p $out/Docs
            cp ./${name}-docs.pdf $out/Docs/
          '';
      };
  };
}
