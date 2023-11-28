{
  self,
  pkgs,
  ...
}: let
  name = "Abstract_Algebra";
  fonts = with pkgs; [victor-mono];
in {
  ${name} = self.lib.buildTypstDoc ./. fonts name;
}
