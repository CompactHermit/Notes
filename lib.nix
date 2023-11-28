{
  pkgs,
  inputs,
  ...
}: let
  #inherit (nixpkgs)
  inherit (pkgs) lib writeShellApplication linkFarm symlinkJoin; ## Use the above implementation,
  inherit (builtins) pathExists readDir readFileType attrValues;
  inherit (lib) concatMapAttrs;
  inherit (lib.strings) hasSuffix removeSuffix;

  typst-packages = linkFarm "typst" [
    {
      name = "typst";
      path = "${inputs.typst-packages}";
    }
  ];
in {
  # I FKING HATE I HAVE TO DO THIS< BUT IT WORKS< FML!!!!!!!
  # TODO :: Find a way to avoid using a direct import.
  _module.args.pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [inputs.typst.overlays.default];
  };
  flake.lib = {
    buildTypstDoc = src: fonts: name: let
      fontsConf = symlinkJoin {
        name = "typst-fonts";
        paths = fonts;
      };
    in
      pkgs.stdenv.mkDerivation {
        name = "${name} Docs";
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
    makeWrapper = package:
      writeShellApplication {
        name = "${package}";
        text = ''
          XDG_CACHE_HOME=${typst-packages} ${lib.getExe pkgs.${package}} "$@"
        '';
      };
    import' = dir: self: pkgs:
    # TODO:: Use fancy oofy goofy functor magic to speed this up
    let
      readModules = dir:
        if pathExists "${dir}.nix" && readFileType "${dir}.nix" == "regular"
        then {default = dir;}
        else if pathExists dir && readFileType dir == "directory"
        then
          concatMapAttrs
          (
            entry: type: let
              dirDefault = "${dir}/${entry}/default.nix";
            in
              if type == "regular" && hasSuffix ".nix" entry
              then {${removeSuffix ".nix" entry} = "${dir}/${entry}";}
              else if pathExists dirDefault && readFileType dirDefault == "regular"
              then {${entry} = dirDefault;}
              else {}
          )
          (readDir dir)
        else {};
    in
      lib.attrsets.foldAttrs (x: y: x // y)
      {}
      (map (file: import file {inherit self pkgs;}) (attrValues (readModules dir)));
  };
}
