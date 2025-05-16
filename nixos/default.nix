{
  imports = map (f: ./. + "/${f}") (
    builtins.filter (f: f != "default.nix") (builtins.attrNames (builtins.readDir ./.))
  );
}
