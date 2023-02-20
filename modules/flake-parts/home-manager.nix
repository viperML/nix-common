{
  config,
  self,
  lib,
  flake-parts-lib,
  withSystem,
  inputs,
  ...
}: {
  options = {
    flake = flake-parts-lib.mkSubmoduleOptions {
      homeModules = lib.mkOption {
        type = with lib.types; lazyAttrsOf unspecified;
        default = {};
        apply = lib.mapAttrs (k: v: {
          _file = "${toString self.outPath}/flake.nix#homeModules.${k}";
          imports = [v];
        });
        description = ''
          HomeModules modules.
          You may use this for reusable pieces of configuration, service modules, etc.
        '';
      };
    };
  };

  config.flake.homeModules.flakes = {
    lib,
    config,
    ...
  }: {
    options = {
      inputs = lib.mkOption {
        type = with lib.types; lazyAttrsOf unspecified;
        default = withSystem config.nixpkgs.system ({
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
        settings."flake-registry" = "${config.xdg.configHome}/nix/registry.json";
      };

      xdg.configFile =
        lib.listToAttrs (map (name: lib.nameValuePair "nix/inputs/${name}" {source = inputs.${name}.outPath;}) config.nix.inputsToPin)
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
  };
}
