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
      channels-to-flakes = ./modules/nixos/channels-to-flakes.nix;
      hm-standalone-shim = ./modules/nixos/hm-standalone-shim.nix;
      xdg = ./modules/nixos/xdg.nix;
    };

    homeModules = {
      channels-to-flakes = ./modules/home-manager/channels-to-flakes.nix;
    };

    lib = import ./lib.nix nixpkgs-lib.lib;
  };
}
