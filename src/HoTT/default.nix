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
  name = "HoTT";
  fonts = with pkgs; [victor-mono];
in {
  ${name} = self.lib.buildTypstDoc ./. fonts name;
  # };
}
