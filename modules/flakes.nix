{
  lib,
  config,
  ...
}: let
  myLib = import ../lib.nix lib;
in {
  options = {
    inputs = lib.mkOption {
      type = with lib.types; lazyAttrsOf unspecified;
      readOnly = true;
      description = ''
        Raw inputs passed from the flake
      '';
    };

    packages = lib.mkOption {
      type = with lib.types; lazyAttrsOf unspecified;
      default = myLib.mkPackages config.inputs config.nixpkgs.hostPlatform.system or config.nixpkgs.system;
      readOnly = true;
    };
  };
}
