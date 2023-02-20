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
        sane = ./modules/nixos/sane.nix;
        xdg = ./modules/nixos/xdg.nix;
        hm-shim = ./modules/nixos/hm-shim.nix;
        well-known = ./modules/nixos/well-known.nix;
      };
    in
      modules
      // {
        default = {
          imports = builtins.attrValues modules;
        };
      };

    homeModules = {
      channels-to-flakes = ./modules/home-manager/channels-to-flakes.nix;
    };

    lib = import ./lib.nix nixpkgs-lib.lib;
  };
}
