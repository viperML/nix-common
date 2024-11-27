{lib, ...}: let
  template = import ../xdg-template.nix "home-manager";
in {
  home.sessionVariables = template.env;
  xdg.enable = lib.mkDefault true;
  xdg.configFile = {
    "npm/npmrc" = template.npmrc;
    "python/pythonrc" = template.pythonrc;
    # "user-dirs.dirs" = template.user-dirs; # FIXME
  };
}
