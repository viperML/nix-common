{
  withSystem,
  inputs,
  self,
  ...
}: {
  flake.nixosModules.flakes = {
    lib,
    config,
    ...
  }: {
    options = {
      inputs = lib.mkOption {
        type = with lib.types; lazyAttrsOf anything;
        default = withSystem config.nixpkgs.hostPlatform.system ({
          inputs',
          self',
          ...
        }:
          inputs' // {self = self';});
      };

      nix.inputsToPin = lib.mkOption {
        type = with lib.types; listOf str;
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
        etc = lib.listToAttrs (map (name: lib.nameValuePair "nix/inputs/${name}" {source = inputs.${name}.outPath;}) config.nix.inputsToPin);
        # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/environment.nix#L20
        variables.NIXPKGS_CONFIG = lib.mkForce "";
      };
    };
  };
}
