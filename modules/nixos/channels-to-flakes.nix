moduleArgs @ {
  lib,
  config,
  ...
}: let
  inputs = moduleArgs.inputs or config.inputs;
in {
  options = with lib; {
    nix.inputsToPin = mkOption {
      type = with types; listOf str;
      default = ["nixpkgs"];
      example = ["nixpkgs" "nixpkgs-master"];
      description = ''
        Names of flake inputs to pin
      '';
    };
  };

  config = {
    nix = {
      registry = lib.listToAttrs (map (name: lib.nameValuePair name {flake = inputs.${name};}) config.nix.inputsToPin);
      settings."flake-registry" = "/etc/nix/registry.json";
      nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
    };

    environment = {
      etc = lib.listToAttrs (map (name: lib.nameValuePair "nix/inputs/${name}" {source = inputs.${name};}) config.nix.inputsToPin);
      # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/environment.nix#L20
      variables.NIXPKGS_CONFIG = lib.mkForce "";
    };
  };
}
