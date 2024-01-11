{
  self,
  pkgs,
  ...
}: let
  name = "TODO4";
  fonts = with pkgs; [victor-mono];
in {
  ${name} = pkgs.lib.typstHelper.buildTypstDoc fonts name;
}
