system: let
  XDG_DATA_HOME = "$HOME/.local/share";
  XDG_CONFIG_HOME = "$HOME/.config";
  XDG_CACHE_HOME = "$HOME/.cache";
  XDG_STATE_HOME = "$HOME/.local/state";
  XDG_RUNTIME_DIR = "$XDG_RUNTIME_DIR";
in {
  env = {
    ANDROID_HOME = "${XDG_DATA_HOME}/android";
    ANDROID_USER_HOME = "${XDG_DATA_HOME}/android";
    # CABAL_CONFIG = "/dev/null";
    CABAL_DIR = "${XDG_DATA_HOME}/cabal";
    CUDA_CACHE_PATH = "${XDG_CACHE_HOME}/nv";
    ERRFILE = "${XDG_CACHE_HOME}/X11/xsession-errors";
    GNUPGHOME = "${XDG_DATA_HOME}/gnupg";
    GRADLE_USER_HOME = "${XDG_DATA_HOME}/gradle";
    HISTFILE = "${XDG_DATA_HOME}/bash/history";
    IPYTHONDIR = "${XDG_CONFIG_HOME}/ipython";
    JULIA_DEPOT_PATH = "${XDG_DATA_HOME}/julia:$JULIA_DEPOT_PATH";
    JUPYTER_CONFIG_DIR = "${XDG_CONFIG_HOME}/jupyter";
    KDEHOME = "${XDG_CONFIG_HOME}/kde";
    LESSHISTFILE = "${XDG_DATA_HOME}/less/history";
    NPM_CONFIG_CACHE = "${XDG_CACHE_HOME}/npm";
    NPM_CONFIG_TMP = "${XDG_RUNTIME_DIR}/npm";
    NPM_CONFIG_USERCONFIG = "${XDG_CONFIG_HOME}/npm/npmrc";
    PYTHONSTARTUP =
      if system == "nixos"
      then "/etc/pythonrc"
      else "${XDG_CONFIG_HOME}/python/pythonrc";
    STEPPATH = "${XDG_DATA_HOME}/step";
    VSCODE_EXTENSIONS = "${XDG_DATA_HOME}/code/extensions";
    XCOMPOSECACHE = "${XDG_CACHE_HOME}/X11/xcompose";
    INPUTRC = "${XDG_CONFIG_HOME}/readline/inputrc";
    GOPATH = "${XDG_DATA_HOME}/go";
    CARGO_HOME = "${XDG_DATA_HOME}/cargo";
    NODE_REPL_HISTORY = "${XDG_DATA_HOME}/node_repl_history";
    PLATFORMIO_CORE_DIR = "${XDG_DATA_HOME}/platformio";
    NUGET_PACKAGES = "${XDG_CACHE_HOME}/NuGetPackages";
    KERAS_HOME = "${XDG_STATE_HOME}/keras";
    SQLITE_HISTORY = "${XDG_CACHE_HOME}/sqlite_history";
    WINEPREFIX = "${XDG_DATA_HOME}/wine";
    GUILE_HISTORY = "${XDG_STATE_HOME}/guile_history";
  };

  xdg_env = {
    inherit
      XDG_DATA_HOME
      XDG_CONFIG_HOME
      XDG_CACHE_HOME
      XDG_STATE_HOME
      ;
  };

  npmrc.text = ''
    prefix=''${XDG_DATA_HOME}/npm
    cache=''${XDG_CACHE_HOME}/npm
    init-module=''${XDG_CONFIG_HOME}/npm/config/npm-init.js
  '';

  pythonrc.text = builtins.readFile ./pythonrc;
}
