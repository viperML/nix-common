{
  inputs ? throw "Pass your flake inputs to NixOS with specialArgs",
  config,
  lib,
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

    xdg.configFile =
      lib.listToAttrs (map (name: lib.nameValuePair "nix/inputs/${name}" {source = inputs.${name};}) config.nix.inputsToPin)
      // {
        "nixpkgs".source = lib.mkDefault (config.lib.file.mkOutOfStoreSymlink "/dev/null");
      };

    home = {
      sessionVariables = {
        NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
        NIXPKGS_CONFIG = "";
      };
    };
  };
}
