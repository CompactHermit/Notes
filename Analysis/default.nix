_: {
  #imports = map (f: "/${f}") (builtins.attrNames (builtins.readDir ./.));
}
