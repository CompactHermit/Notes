{self, ...}: let
  name = "TODO2";
in {
  perSystem = {
    lib,
    pkgs,
    ...
  }: let
    fonts = with pkgs; [victor-mono];
  in {
    packages.${name} = self.lib.buildTypstDoc ./. fonts name;
  };
}
