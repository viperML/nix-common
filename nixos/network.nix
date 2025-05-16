{lib, ...}: {
  # https://github.com/numtide/srvos/blob/main/nixos/common/networking.nix
  networking.firewall.allowPing = true;
  networking.useNetworkd = lib.mkDefault true;
  networking.useDHCP = lib.mkDefault false;
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.network.wait-online.enable = false;
  systemd.services.systemd-networkd.stopIfChanged = false;
  systemd.services.systemd-resolved.stopIfChanged = false;

  # https://tailscale.com/kb/1019/subnets?tab=linux#enable-ip-forwarding
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = "1";
    "net.ipv6.conf.all.forwarding" = "1";
  };
}
