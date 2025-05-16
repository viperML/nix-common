{
  config,
  lib,
  pkgs,
  ...
}: let
  mkFirewallReport = interfaceName: interface: [
    (map (p: "TCP\t${toString p}\t${interfaceName}") interface.allowedTCPPorts)
    (map ({
      from,
      to,
    }: "TCP\t${toString from}:${toString to}\t${interfaceName}")
    interface.allowedTCPPortRanges)
    (map (p: "UDP\t${toString p}\t${interfaceName}") interface.allowedUDPPorts)
    (map ({
      from,
      to,
    }: "UDP\t${toString from}:${toString to}\t${interfaceName}")
    interface.allowedTCPPortRanges)
  ];
in {
  system.build.firewallReport = pkgs.writeText "firewall-report" (lib.concatStringsSep "\n" (lib.flatten [
    (mkFirewallReport "" config.networking.firewall)
    (map ({
      name,
      value,
    }:
      mkFirewallReport name value) (lib.attrsToList config.networking.firewall.interfaces))
  ]));

  environment.etc."nixos/firewall-report".source = config.system.build.firewallReport;
}
