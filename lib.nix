{
  pkgs,
  fetches,
  ...
}:
let
  #inherit (nixpkgs)
  inherit (pkgs)
    lib
    writeShellApplication
    linkFarm
    symlinkJoin
    ; # # We simply call packages when it's in scope, rather then doing a full import
  #inherit (nixpkgs) lib;
  inherit (builtins)
    pathExists
    readDir
    readFileType
    attrValues
    match
    head
    ;
  inherit (lib) concatMapAttrs getExe;
  inherit (lib.strings) hasSuffix removeSuffix;
  inherit (lib.attrsets) foldAttrs;

  typst-packages = linkFarm "typst" [
    {
      name = "typst";
      path = "${fetches.typst-packages.src}";
    }
  ];
in
{
  # I FKING HATE I HAVE TO DO THIS< BUT IT WORKS< FML!!!!!!!
  # TODO :: Find a way to avoid using a direct import.
  buildTypstDoc =
    fonts: name':
    let
      fontsConf = symlinkJoin {
        name = "typst-fonts";
        paths = fonts;
      };
      name =
        if ((match ".*/(.*)" "${name'}") != null) then (head (match ".*/(.*)" "${name'}")) else name';
    in
    pkgs.stdenv.mkDerivation {
      name = "${name}";
      src = ./src; # Avoid have self copied over and over
      buildInputs = builtins.attrValues {
        inherit (pkgs) typst;
      };
      buildPhase = ''
        TYPST_ROOT=./. XDG_CACHE_HOME=${typst-packages} ${getExe pkgs.typst} compile --font-path ${fontsConf} ./${name'}/main.typ ${name}-docs.pdf
      '';
      installPhase = ''
        mkdir -p $out/Docs
        cp ./${name}-docs.pdf $out/Docs/
      '';
    };
  makeWrapper =
    {
      package,
      flags ? [ ],
      ...
    }@args:
    let
      _flags = if flags != [ ] then "" else lib.escapeShellArgs flags;
    in
    writeShellApplication {
      name = "${package}";
      text = ''
        #XDG_CACHE_HOME=/tmp/typst ${getExe pkgs.${package}} "$@"
        TYPST_ROOT=./. XDG_CACHE_HOME=${typst-packages} ${getExe pkgs.${package}} ${_flags} "$@"
      '';
    };
  import' =
    dir: self: pkgs:
    # TODO:: Use fancy oofy goofy functor magic to speed this shit up
    let
      readModules =
        dir:
        if pathExists "${dir}.nix" && readFileType "${dir}.nix" == "regular" then
          { default = dir; }
        else if pathExists dir && readFileType dir == "directory" then
          concatMapAttrs (
            entry: type:
            let
              dirDefault = "${dir}/${entry}/default.nix";
            in
            if type == "regular" && hasSuffix ".nix" entry then
              { ${removeSuffix ".nix" entry} = "${dir}/${entry}"; }
            else if pathExists dirDefault && readFileType dirDefault == "regular" then
              { ${entry} = dirDefault; }
            else if pathExists "${dir}/${entry}" && type == "directory" then
              (readModules "${dir}/${entry}")
            else
              { }
          ) (readDir dir)
        else
          { };
    in
    foldAttrs (x: y: x // y) { } (
      map (file: import file { inherit self pkgs; }) (attrValues (readModules dir))
    );

}
