{
  description = "Common components for my projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }:
    with nixpkgs.lib;
    with builtins; {
      nixosModules =
        mapAttrs'
        (name: _: nameValuePair (removeSuffix ".nix" name) (import (./modules/nixos + "/${name}")))
        (readDir ./modules/nixos);

      homeModules =
        mapAttrs'
        (name: _: nameValuePair (removeSuffix ".nix" name) (import (./modules/home-manager + "/${name}")))
        (readDir ./modules/home-manager);

      lib = import ./lib.nix nixpkgs.lib;
    };
}
