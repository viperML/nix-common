let
  template = import ../xdg-template.nix "nixos";
in
{
  environment.sessionVariables = template.env // template.xdg_env;

  environment.etc = {
    inherit (template) npmrc wgetrc;
    "xdg/user-dirs.defaults".text = ''
      DESKTOP=Desktop
      DOCUMENTS=Documents
      DOWNLOAD=Downloads
      MUSIC=Music
      PICTURES=Pictures
      PUBLICSHARE=Public
      TEMPLATES=Templates
      VIDEOS=Videos
    '';
  };
}
