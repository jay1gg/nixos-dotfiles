{pkgs, ...}: {
  # VPN support with GUI client
  
  # Enable NetworkManager for VPN GUI support
  networking.networkmanager = {
    enable = true;
    # VPN plugins
    plugins = with pkgs; [
      networkmanager-openvpn # OpenVPN support
      networkmanager-l2tp # L2TP/IPSec support
    ];
  };

  # VPN client packages
  environment.systemPackages = with pkgs; [
    # OpenVPN
    openvpn # OpenVPN client

    # L2TP/IPSec
    xl2tpd # L2TP daemon
    libreswan # IPSec support (required for L2TP)

    # GUI VPN Manager
    networkmanagerapplet # NetworkManager GUI applet

    # VPN utilities
    wireguard-tools # WireGuard support (bonus)
  ];

  # Enable necessary kernel modules for VPN
  boot.kernelModules = [
    "ppp_generic"
    "ppp_async"
    "l2tp_core"
    "l2tp_ppp"
    "xfrm4_tunnel"
  ];

  # VPN-related environment variables
  environment.variables = {
    OPENVPN_DIR = "/etc/openvpn";
  };
}
