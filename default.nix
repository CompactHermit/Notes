{
  self,
  pkgs,
  ...
}: {
  Analysis = pkgs.callPackage ./Anal {inherit self pkgs;};
  Functiononal_Analysis = pkgs.callPackage ./Functional_Anal {inherit self pkgs;};
  Complex_Anal = pkgs.callPackage ./Complex_Anal {inherit self pkgs;};
}
