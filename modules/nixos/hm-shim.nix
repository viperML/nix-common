{lib, ...}: {
  environment.extraInit = lib.mkAfter (lib.fileContents ../home-manager/hm-shim.sh);
}
