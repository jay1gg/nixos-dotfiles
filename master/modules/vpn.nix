# VPN Configuration
# Provides VPN client support with GUI and command-line tools
{pkgs, ...}: {
  # NetworkManager integration for VPN
  # Enables VPN connections through NetworkManager GUI
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn   # OpenVPN protocol support
      networkmanager-l2tp      # L2TP/IPSec protocol support
    ];
  };

  # VPN client packages and utilities
  environment.systemPackages = with pkgs; [
    # OpenVPN - Open-source VPN implementation
    openvpn                    # OpenVPN client for .ovpn config files

    # L2TP/IPSec - VPN protocols for enterprise environments
    xl2tpd                     # L2TP daemon for L2TP connections
    libreswan                  # IPSec support (required for L2TP/IPSec)

    # GUI Network Manager
    networkmanagerapplet       # System tray applet for VPN management

    # Additional VPN protocols
    wireguard-tools            # WireGuard VPN protocol (modern, fast, secure)
  ];

  # Kernel modules required for VPN functionality
  # These provide low-level VPN protocol support
  boot.kernelModules = [
    "ppp_generic"              # Point-to-Point Protocol (used by L2TP)
    "ppp_async"                # Asynchronous PPP mode
    "l2tp_core"                # L2TP protocol core
    "l2tp_ppp"                 # L2TP over PPP
    "xfrm4_tunnel"             # IPSec tunneling for IPv4
  ];

  # VPN environment paths
  environment.variables = {
    OPENVPN_DIR = "/etc/openvpn";  # Configuration directory for OpenVPN files
  };
}
