{
  lib,
  config,
  ...
}: {
  options = {
    unsafeFlakePath = lib.mkOption {
      type = with lib.types; path;
      description = "Path to the mutable flake directory";
      default = "/var/empty";
    };
  };

  config = {
    home.sessionVariables.FLAKE = config.unsafeFlakePath;
  };
}
