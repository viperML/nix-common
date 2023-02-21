{
  description = "Common components for my projects";

  inputs = {
    nixpkgs-lib.url = "github:NixOS/nixpkgs/nixos-unstable?dir=lib";
  };

  outputs = {
    self,
    nixpkgs-lib,
  }: {
    nixosModules = {
      default = ./modules/nixos;
      hm-module = ./modules/nixos/hm-module.nix;
    };
    homeModules.default = ./modules/home-manager;

    lib = import ./lib.nix nixpkgs-lib.lib;
  };
}
