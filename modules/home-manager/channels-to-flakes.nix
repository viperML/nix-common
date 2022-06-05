{
  config,
  lib,
  inputs ? throw "Please pass your inputs to extraSpecialArgs",
  ...
}:
with lib; let
  folder-inputs = mapAttrs' (n: v: nameValuePair "nix/inputs/${n}" {source = v.outPath;}) inputs;

  registry = builtins.toJSON {
    flakes =
      mapAttrsToList (n: v: {
        exact = true;
        from = {
          id = n;
          type = "indirect";
        };
        to = {
          path = v.outPath;
          type = "path";
        };
      })
      inputs;
    version = 2;
  };
in {
  xdg.configFile =
    folder-inputs
    // {
      "nix/registry.json".text = registry;
    };

  home.sessionVariables ={
    NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
    NIXPKGS_CONFIG = "";
  };


  home.activation.useFlakeChannels = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/.nix-defexpr
    $DRY_RUN_CMD rm -rf $VERBOSE_ARG $HOME/.nix-defexpr/channels
    $DRY_RUN_CMD ln -sf $VERBOSE_ARG /dev/null $HOME/.nix-defexpr/channels
    $DRY_RUN_CMD rm -rf $VERBOSE_ARG $HOME/.nix-defexpr/channels_root
    $DRY_RUN_CMD ln -sf $VERBOSE_ARG /dev/null $HOME/.nix-defexpr/channels_root

    $DRY_RUN_CMD rm -rf $VERBOSE_ARG $HOME/.nix-channels
    $DRY_RUN_CMD ln -sf $VERBOSE_ARG /dev/null $HOME/.nix-channels

    $DRY_RUN_CMD rm -rf $VERBOSE_ARG $HOME/.config/nixpkgs
    $DRY_RUN_CMD ln -sf $VERBOSE_ARG /dev/null $HOME/.config/nixpkgs
  '';
}
