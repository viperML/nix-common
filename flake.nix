{
  inputs = {
    nixpkgs-lib.url = "github:NixOS/nixpkgs/nixos-unstable?dir=lib";
  };

  outputs =
    {
      self,
      nixpkgs-lib,
    }:
    let
      inherit (nixpkgs-lib) lib;
    in
    {
      nixosModules = lib.mapAttrs' (
        name: _: lib.nameValuePair (lib.removeSuffix ".nix" name) (./nixos + "/${name}")
      ) (builtins.readDir ./nixos);

      lib = import ./lib.nix lib;
    };
}
