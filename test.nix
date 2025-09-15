import <nixpkgs/nixos> {
  configuration = {

    imports = [
      ./nixos
    ];

    fileSystems."/".device = "nodev";
    boot.isContainer = true;
    services.resolved.enable = false;
  };
}
