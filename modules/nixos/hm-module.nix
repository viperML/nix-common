{config, ...}: {
  home-manager.sharedModules = [
    ../home-manager
    {
      inherit (config) inputs;
    }
  ];
}
