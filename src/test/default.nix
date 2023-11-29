{
  self,
  pkgs,
  ...
}:
# {self,...}:
# {perSystem = {
#   self,
#   config,
#   pkgs,
#   ...
#       }:
let
  name = "Test";
  fonts = with pkgs; [victor-mono];
in {
  ${name} = self.lib.buildTypstDoc ./. fonts name;
  # };
}
