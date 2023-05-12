{
  connect-timeout = 5;

  extra-experimental-features = [
    "nix-command"
    "flakes"
    "repl-flake"
  ];

  builders-use-substitutes = true;
}
