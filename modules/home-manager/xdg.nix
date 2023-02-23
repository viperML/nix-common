let
  template = import ../xdg-template.nix "home-manager";
in {
  home.sessionVariables = template.env;
  xdg.configFile = {
    inherit (template) npmrc;
    "python/pythonrc" = template.pythonrc;
    "user-dirs.dirs" = template.user-dirs;
  };
}
