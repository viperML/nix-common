{
  nix.settings = import ../nix-conf.nix;

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };
}
