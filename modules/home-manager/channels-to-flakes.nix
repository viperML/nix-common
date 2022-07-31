{
  config,
  lib,
  inputs ? throw "Please pass your inputs to extraSpecialArgs",
  ...
}: {
  xdg.configFile = with lib; mapAttrs' (n: v: nameValuePair "nix/inputs/${n}" {source = v.outPath;}) inputs;

  nix = {
    registry = with lib; mapAttrs' (name: value: nameValuePair name {flake = value;}) inputs;
    settings = {
      "flake-registry" = "${config.xdg.configHome}/nix/registry.json";
    };
  };

  home.sessionVariables = {
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
