{
  self,
  pkgs,
  ...
}: let
  name = "TODO4";
  fonts = with pkgs; [victor-mono];
in {
  ${name} = self.lib.buildTypstDoc ./. fonts name;
}
