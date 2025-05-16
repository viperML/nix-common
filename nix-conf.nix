{
  allow-import-from-derivation = false;

  use-xdg-base-directories = true;

  connect-timeout = 5;

  extra-experimental-features = [
    "nix-command"
    "flakes"
  ];

  builders-use-substitutes = true;

  auto-optimise-store = true;

  # store = "daemon";
}
