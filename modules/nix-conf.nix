{
  connect-timeout = 5;

  extra-experimental-features = [
    "nix-command"
    "flakes"
  ];

  builders-use-substitutes = true;
}
