{
  users.users.root.home = "/var/empty";

  systemd.tmpfiles.rules = [
    "D /nix/var/nix/profiles/per-user/root 755 root root - -"
  ];
}
