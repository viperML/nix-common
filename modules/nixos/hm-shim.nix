{lib, ...}: {
  environment.extraInit = lib.fileContents ../home-manager/hm-shim.sh;
}
