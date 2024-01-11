{
  self,
  pkgs,
  ...
}: let
  name = "Analysis/Functional_Anal";
  fonts = with pkgs; [victor-mono];
in {${name} = pkgs.lib.typstHelper.buildTypstDoc fonts name;}
