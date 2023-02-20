# Saner defaults
{
  lib,
  config,
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

  # Mostly useless and breaks stuff
  environment.noXlibs = false;

  # https://github.com/numtide/srvos/blob/main/nixos/common/networking.nix
  networking.firewall.allowPing = true;
  networking.useNetworkd = lib.mkDefault true;
  networking.useDHCP = lib.mkDefault false;
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.network.wait-online.enable = false;
  systemd.services.systemd-networkd.stopIfChanged = false;
  systemd.services.systemd-resolved.stopIfChanged = false;

  nix.settings = import ../nix-conf.nix;
  nix.daemonCPUSchedPolicy = lib.mkDefault "batch";
  nix.daemonIOSchedClass = lib.mkDefault "idle";
  nix.daemonIOSchedPriority = lib.mkDefault 7;

  # https://github.com/numtide/srvos/blob/main/nixos/common/openssh.nix
  services.openssh = {
    settings.X11Forwarding = false;
    # settings.KbdInteractiveAuthentication = false;
    # settings.PasswordAuthentication = false;
    settings.UseDns = false;
    # Only allow system-level authorized_keys to avoid injections.
    # We currently don't enable this when git-based software that relies on this is enabled.
    # It would be nicer to make it more granular using `Match`.
    # However those match blocks cannot be put after other `extraConfig` lines
    # with the current sshd config module, which is however something the sshd
    # config parser mandates.
    authorizedKeysFiles =
      lib.mkIf (!config.services.gitea.enable && !config.services.gitlab.enable && !config.services.gitolite.enable && !config.services.gerrit.enable)
      (lib.mkForce ["/etc/ssh/authorized_keys.d/%u"]);

    # unbind gnupg sockets if they exists
    extraConfig = "StreamLocalBindUnlink yes";
  };

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
}
