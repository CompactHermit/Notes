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
  name = "Analysis/Complex_Anal";
  fonts = with pkgs; [victor-mono];
in {${name} = pkgs.lib.typstHelper.buildTypstDoc fonts name;}
#(pkgs.lib.typstHelper.buildTypstDoc fonts name)

