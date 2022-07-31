{
  inputs ? throw "Please add the flake inputs to specialArgs",
  lib,
  ...
}:
with lib; {
  nix = {
    registry = mapAttrs' (name: value: nameValuePair name {flake = value;}) inputs;
    settings = {
      "flake-registry" = "/etc/nix/registry.json";
    };
    nixPath = [
      "nixpkgs=/etc/nix/inputs/nixpkgs"
    ];
  };

  environment.etc = mapAttrs' (name: value: nameValuePair "nix/inputs/${name}" {source = value.outPath;}) inputs;
  environment.variables.NIXPKGS_CONFIG = lib.mkForce "";
}
