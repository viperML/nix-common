{
  allow-import-from-derivation = false;

  use-xdg-base-directories = true;

  connect-timeout = 5;

  extra-experimental-features = [
    "nix-command"
    "flakes"
    "repl-flake"
  ];

  builders-use-substitutes = true;
}
