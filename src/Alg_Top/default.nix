{
  self,
  pkgs,
  ...
}: let
  name = "TODO2";
  fonts = with pkgs; [victor-mono];
in {
  ${name} = self.lib.buildTypstDoc ./. fonts name;
}
