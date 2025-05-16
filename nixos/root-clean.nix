{
  fileSystems."/root" = {
    fsType = "tmpfs";
    device = "none";
    options = [
      "defaults"
      "size=100M"
      "mode=0700"
    ];
    neededForBoot = true;
  };

  systemd.tmpfiles.rules = [
    "D /nix/var/nix/profiles/per-user/root 755 root root - -"
  ];
}
