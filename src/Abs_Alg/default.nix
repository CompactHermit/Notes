{
  pkgs,
  ...
}:
let
  inherit (pkgs.lib.typstHelper) buildTypstDoc;
  name = "Abstract_Algebra";
  fonts = builtins.attrValues { inherit (pkgs) victor-mono; };
in
{
  ${name} = buildTypstDoc fonts name;
}
