{self, ...}: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: let
    name = "test";
    fonts = with pkgs; [victor-mono];
  in {
    packages.${name} = self.lib.buildTypstDoc ./. fonts name;
  };
}
