{pkgs, ...}: {
  home.packages = [
    (pkgs.writeTextDir "etc/profile.d/zz-hm-shim.sh" (builtins.readFile ./hm-shim.sh))
  ];
}
