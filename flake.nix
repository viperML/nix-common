{
  description = "Common components for my projects";

  inputs = {
    nixpkgs-lib.url = "github:NixOS/nixpkgs/nixos-unstable?dir=lib";
  };

  outputs = {
    self,
    nixpkgs-lib,
  }: {
    nixosModules = let
      modules = {
        # channels-to-flakes = ./modules/nixos/channels-to-flakes.nix;
        hm-shim = ./modules/nixos/hm-shim.nix;
        network = ./modules/nixos/network.nix;
        sane = ./modules/nixos/sane.nix;
        ssh = ./modules/nixos/ssh.nix;
        well-known = ./modules/nixos/well-known.nix;
        xdg = ./modules/nixos/xdg.nix;
      };
    in
      modules
      // {
        default.imports = builtins.attrValues modules;
        flakes = import ./modules/nixos/flakes.nix;
      };

    homeModules = {
      channels-to-flakes = ./modules/home-manager/channels-to-flakes.nix;
    };

    flakeModules = {
      nixos = ./modules/flake-parts/nixos.nix;
    };

    lib = import ./lib.nix nixpkgs-lib.lib;
  };
}
