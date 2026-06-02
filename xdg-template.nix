system: let
  XDG_DATA_HOME = "\${HOME}/.local/share";
  XDG_CONFIG_HOME = "\${HOME}/.config";
  XDG_CACHE_HOME = "\${HOME}/.cache";
  XDG_STATE_HOME = "\${HOME}/.local/state";
in {
  env = {
    # CABAL_CONFIG = "/dev/null";
    ANDROID_HOME = "${XDG_DATA_HOME}/android";
    ANDROID_USER_HOME = "${XDG_DATA_HOME}/android";
    ANSIBLE_HOME = "${XDG_DATA_HOME}/ansible";
    CABAL_DIR = "${XDG_DATA_HOME}/cabal";
    CARGO_HOME = "${XDG_DATA_HOME}/cargo";
    CUDA_CACHE_PATH = "${XDG_CACHE_HOME}/nv";
    DOTNET_CLI_HOME = "${XDG_DATA_HOME}/dotnet";
    ERRFILE = "${XDG_CACHE_HOME}/X11/xsession-errors";
    GDBHISTFILE = "${XDG_CACHE_HOME}/gdb_history";
    GNUPGHOME = "${XDG_DATA_HOME}/gnupg";
    GOPATH = "${XDG_DATA_HOME}/go";
    GRADLE_USER_HOME = "${XDG_DATA_HOME}/gradle";
    GUILE_HISTORY = "${XDG_STATE_HOME}/guile_history";
    HISTFILE = "${XDG_DATA_HOME}/bash/history";
    INPUTRC = "${XDG_CONFIG_HOME}/readline/inputrc";
    IPYTHONDIR = "${XDG_CONFIG_HOME}/ipython";
    JULIA_DEPOT_PATH = "${XDG_DATA_HOME}/julia";
    JUPYTER_CONFIG_DIR = "${XDG_CONFIG_HOME}/jupyter";
    KDEHOME = "${XDG_CONFIG_HOME}/kde";
    KERAS_HOME = "${XDG_STATE_HOME}/keras";
    LESSHISTFILE = "${XDG_DATA_HOME}/less/history";
    NODE_REPL_HISTORY = "${XDG_DATA_HOME}/node_repl_history";
    NPM_CONFIG_CACHE = "${XDG_CACHE_HOME}/npm";
    NPM_CONFIG_PREFIX = "${XDG_DATA_HOME}/npm";
    NPM_CONFIG_USERCONFIG = "${XDG_CONFIG_HOME}/npm/npmrc";
    NUGET_PACKAGES = "${XDG_CACHE_HOME}/NuGetPackages";
    PLATFORMIO_CORE_DIR = "${XDG_DATA_HOME}/platformio";
    PSQL_HISTORY = "${XDG_DATA_HOME}/psql_history";
    PYTHON_HISTORY = "${XDG_CACHE_HOME}/python_history";
    SQLITE_HISTORY = "${XDG_CACHE_HOME}/sqlite_history";
    STEPPATH = "${XDG_DATA_HOME}/step";
    VSCODE_EXTENSIONS = "${XDG_DATA_HOME}/code/extensions";
    WGETRC = "/etc/wgetrc";
    WINEPREFIX = "${XDG_DATA_HOME}/wine";
    XCOMPOSECACHE = "${XDG_CACHE_HOME}/X11/xcompose";
  };

  npmrc.text = ''
    prefix=''${XDG_DATA_HOME}/npm
    cache=''${XDG_CACHE_HOME}/npm
    init-module=''${XDG_CONFIG_HOME}/npm/config/npm-init.js
  '';

  wgetrc.text = ''
    hsts-file = /dev/null
  '';
}
