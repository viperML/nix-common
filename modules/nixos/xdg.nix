let
  template = import ../xdg-template.nix "nixos";
in {
  environment.sessionVariables = template.env;

  environment.etc = {
    inherit (template) pythonrc npmrc;
    "xdg/user-dirs.defaults" = template.user-dirs;
  };
}
