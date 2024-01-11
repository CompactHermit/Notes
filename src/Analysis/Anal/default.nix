{
  self,
  pkgs,
  ...
}: let
  name = "Analysis/Anal";
  fonts = with pkgs; [victor-mono];
in {${name} = pkgs.lib.typstHelper.buildTypstDoc fonts name;}
#pkgs.lib.typstHelper.buildTypstDoc fonts name

