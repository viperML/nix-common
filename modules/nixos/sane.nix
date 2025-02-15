# Saner defaults
{
  lib,
  config,
  pkgs,
  ...
}: {
  boot.initrd.systemd.enable = lib.mkDefault (!config.boot.initrd.network.enable && !config.boot.initrd.services.swraid.enable && !config.boot.isContainer);

  documentation = {
    # Whether to install documentation of packages from environment.systemPackages into the generated system path. See "Multiple-output packages" chapter in the nixpkgs manual for more info.
    enable = lib.mkDefault true;
    # Whether to install manual pages and the man command. This also includes "man" outputs.
    man.enable = lib.mkDefault true;
    # Whether to install documentation distributed in packages' /share/doc. Usually plain text and/or HTML. This also includes "doc" outputs.
    doc.enable = lib.mkForce false;
    # Installs man and doc pages if they are enabled
    # Takes too much time and are not cached
    nixos.enable = lib.mkForce false;
    # Whether to install info pages and the info command. This also includes "info" outputs.
    info.enable = lib.mkForce false;
  };

  services.pulseaudio.enable = lib.mkForce false;

  time.timeZone = lib.mkDefault "UTC";

  nix.settings = import ../nix-conf.nix;
  nix.daemonCPUSchedPolicy = lib.mkDefault "batch";
  nix.daemonIOSchedClass = lib.mkDefault "idle";
  nix.daemonIOSchedPriority = lib.mkDefault 7;

  security.sudo.extraConfig = ''
    Defaults pwfeedback
    Defaults env_keep += "EDITOR PATH"
    Defaults timestamp_timeout=300
    Defaults lecture=never
    Defaults passprompt="[31m sudo: password for %p@%h, running as %U:[0m "
  '';

  security.rtkit.enable = config.services.pipewire.enable;
  services.pipewire = {
    enable = config.services.xserver.enable;
    pulse.enable = true;
    alsa.enable = true;
  };

  networking.hostId = lib.mkDefault (builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName));

  environment.profiles = [
    "$HOME/.local/state/nix/profiles/profile"
  ];

  services.xserver.desktopManager.xterm.enable = false;

  environment.etc.issue.source = pkgs.writeText "issue" (with config.system.nixos; ''
    ${distroName} ${release} ${codeName}
  '');

  programs.command-not-found.enable = false;

  systemd.services.nix-daemon = {
    environment = {
      HOME = "/nix/var/nix/nix-daemon";
      XDG_CACHE_HOME = "/nix/var/nix/nix-daemon";
    };
  };
}
