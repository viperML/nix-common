homeModules: {config, ...}: {
  _file = ./hm-module.nix;
  home-manager.sharedModules = [
    homeModules.default
    {
      inherit (config) inputs;
    }
  ];
}
