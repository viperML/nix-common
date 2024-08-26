{
  lib,
  config,
  inputs ? throw "Pass inputs to specialArgs or extraSpecialArgs",
  ...
}: {
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
      nixPath = ["nixpkgs=flake:nixpkgs"];
    };

    environment = {
      # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/environment.nix#L20
      variables.NIXPKGS_CONFIG = lib.mkForce "";
    };
  };
}
