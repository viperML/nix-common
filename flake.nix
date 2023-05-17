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
      defaultModules = {
        channels-to-flakes = ./modules/nixos/channels-to-flakes.nix;
        hm-shim = ./modules/nixos/hm-shim.nix;
        network = ./modules/nixos/network.nix;
        sane = ./modules/nixos/sane.nix;
        ssh = ./modules/nixos/ssh.nix;
        well-known = ./modules/nixos/well-known.nix;
        xdg = ./modules/nixos/xdg.nix;
        root-clean = ./modules/nixos/root-clean.nix;
      };
    in
      defaultModules
      // {
        default.imports = builtins.attrValues defaultModules;
      };

    homeModules = let
      defaultModules = {
        channels-to-flakes = ./modules/home-manager/channels-to-flakes.nix;
        flake-path = ./modules/home-manager/flake-path.nix;
        xdg = ./modules/home-manager/xdg.nix;
      };
    in
      defaultModules
      // {
        default.imports = builtins.attrValues defaultModules;
      };

    lib = import ./lib.nix nixpkgs-lib.lib;
  };
}
