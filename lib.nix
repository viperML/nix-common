lib: {
  /*
  Utility function to collect the packages or legacyPackages for a system.
  Because typing `inputs.nixpkgs.legacyPackages.${system}.package` is a PITA,
  this function converts it to `result.package`

  It can be useful to pair with `speciaArgs`:
  specialArgs = {
    packages = mkPackages inputs;
  }
  So you have access in your modules to `packages.<input>.<package name>`

  mkPackages inputs "x86_64-linux"
  => {
    nixpkgs = {
      package1 = ...; package2 = ...;
    };
    other-input = {
      package1 = ...; package2 = ...;
    };
  }
  */
  mkPackages = system: inputs:
    builtins.mapAttrs (name: value: let
      legacyPackages = value.legacyPackages.${system} or {};
      packages = value.packages.${system} or {};
    in
      legacyPackages // packages)
    inputs;

  /*
  Usage in a flake:
  mkFlakeVersion "1.4" self
  => "1.4+date=YYYY-MM-DD"
  */
  mkFlakeVersion = version: longDate:
    lib.concatStrings [
      (
        if version == null
        then "0.pre"
        else version
      )
      "+date="
      (lib.concatStringsSep "-" [
        (builtins.substring 0 4 longDate)
        (builtins.substring 4 2 longDate)
        (builtins.substring 6 2 longDate)
      ])
    ];
}
