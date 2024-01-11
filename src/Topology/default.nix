{
  pkgs,
  ...
}:
let
  name = "TODO3";
  fonts = with pkgs; [ victor-mono ];
in
{
  ${name} = pkgs.lib.typstHelper.buildTypstDoc fonts name;
}
