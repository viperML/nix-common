{
  config,
  lib,
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
      settings."flake-registry" = "${config.xdg.configHome}/nix/registry.json";
    };

    xdg.configFile = {
      "nixpkgs".source = lib.mkDefault (config.lib.file.mkOutOfStoreSymlink "/var/empty");
    };

    home = {
      sessionVariables = {
        NIX_PATH = let
          prev = "$\{NIX_PATH:+:$NIX_PATH}";
        in "nixpkgs=flake:nixpkgs${prev}";
        NIXPKGS_CONFIG = "";
      };
    };
  };
}
