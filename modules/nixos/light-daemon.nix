{...}: let
  file = "/run/dynamic-nix.conf";
in {
  system.activationScripts.dynamicNixConf = {
    text = ''
      echo "cores = $(( $(nproc) - 2))" > ${file}
    '';
  };
  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    extraOptions = ''
      !include ${file}
    '';
  };
}
