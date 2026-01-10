{
  description = "Jay's nixos-dotfiles";
  
- [WireGuard Documentation](https://www.wireguard.com/)- [NetworkManager VPN](https://wiki.gnome.org/Projects/NetworkManager/VPN)- [L2TP/IPSec Guide](https://en.wikipedia.org/wiki/L2TP/IPsec)- [OpenVPN Documentation](https://openvpn.net/community-resources/)## 📚 Further Reading```/etc/openvpn/            # System-wide (requires sudo)# or~/.config/openvpn/       # User config directory```bashMost VPN providers give you `.ovpn` files for OpenVPN. Place them in:## 🔗 Provider Configuration Files```ip addr show             # Look for tun/ppp interfaces# View VPN interfaceip route show# Check routing tablesudo nethogs             # Show traffic by connection# Monitor network trafficcurl ifconfig.me          # Shows your IP (should be VPN IP)# Test VPN connection```bash## 📖 Useful Commands```cat /etc/resolv.conf# Check DNS configurationsudo systemctl restart systemd-resolved# Flush DNS cache```bash### DNS Issues with VPN```sudo systemctl status NetworkManager# Check service statussudo systemctl restart NetworkManager# Restart NetworkManager```bash### NetworkManager Not Showing VPN```sudo ipsec status# Check ipsecsudo dmesg | tail -20# View kernel logssudo systemctl status xl2tpd# Check xl2tpd status```bash### L2TP Connection Issues```sudo openvpn --config config.ovpn --verb 4# Verbose outputsudo journalctl -u openvpn -f# Check logs```bash### OpenVPN Connection Issues## 🐛 Troubleshooting   ```   down /etc/openvpn/update-resolv-conf   up /etc/openvpn/update-resolv-conf   script-security 2   ```5. **Enable DNS leak protection** in OpenVPN config:4. **Use certificates** over password authentication when possible3. **Keep OpenVPN/L2TP updated** - system updates handle this2. **Store .ovpn configs securely** - don't share with others1. **Always use strong passwords** for VPN credentials## 🔐 Security Tips```nmcli connection show | grep vpn```bash### List All VPN Connections```nmcli connection up vpn-name```bash### Connect to VPN```nmcli connection down vpn-name```bash### Disconnect VPN```nmcli connection show --active```bash### View Active Connections## 📱 VPN Status Management   - Enter any required credentials   - Select connection from network menu   - Click "Save"6. **Save and Connect**   - DNS: Usually handled by VPN   - Routes: Configure if needed5. **IPv4 Settings** tab   - Key Password: Enter if encrypted   - Private Key: Browse to `.key` file   - Client Certificate: Browse to `.crt` file   - CA Certificate: Browse to `.crt` file   - Type: Certificate (or Password if applicable)   - Gateway: VPN server address4. **Configure OpenVPN**   - Connection type: "OpenVPN"   - Click "+" button3. **Add New VPN**   - Select "Edit Connections..." 2. **Edit Connections**   - Click network icon in system tray1. **Open NetworkManager Applet**### Step-by-Step: Adding OpenVPN via GUI## 🔧 NetworkManager VPN GUI (Recommended Method)```sudo wg-quick down wg0```bash### Stop WireGuard```sudo wg show```bash### Check Status```sudo wg-quick up wg0```bash### Start WireGuard```PersistentKeepalive = 25AllowedIPs = 0.0.0.0/0Endpoint = vpn.example.com:51820PublicKey = <server-public-key>[Peer]DNS = 8.8.8.8PrivateKey = <your-private-key>Address = 10.0.0.2/24[Interface]```iniCreate `/etc/wireguard/wg0.conf`:```sudo chmod 700 /etc/wireguardsudo mkdir -p /etc/wireguard```bash### Create WireGuard Config```cat publickeycat privatekey# View keyswg genkey | tee privatekey | wg pubkey > publickeyumask 077# Generate keys```bash### Setup WireGuard## 🌐 WireGuard (Bonus)```sudo systemctl stop xl2tpd# Stop xl2tpdsudo echo "d vpn-connection" > /var/run/xl2tpd/control# Disconnect```bash### Disconnect L2TP```sudo ipsec status# View L2TP sessionssudo systemctl status xl2tpd# Check xl2tpd status```bash### View L2TP Status```ip addr show | grep ppp# Check connectionsudo echo "c vpn-connection" > /var/run/xl2tpd/control# Connectsudo systemctl start xl2tpd# Start xl2tpd daemon```bash### Start L2TP Connection```password your_passwordname usernameconnect-delay 0lockdebugnodefaultroutemru 1410mtu 1410idle 1800crtsctsauthasyncmap 0require-mschap-v2refuse-eapipcp-accept-remoteipcp-accept-local```Create `/etc/ppp/options.l2tpd.vpn`:```pppoptfile = /etc/ppp/options.l2tpd.vpnppp debug = yeslns = VPN_SERVER_ADDRESS[lac vpn-connection]```iniCreate `/etc/xl2tpd/xl2tpd.conf`:### Configuration File Setup## 📡 L2TP/IPSec (Command Line)4. Save and connect   - Domain (if required)   - Password   - Username   - Gateway3. Enter:2. Add → VPN → PPTP1. NetworkManager applet → Edit Connections### Via GUI (NetworkManager)```sudo pptpclient SERVER_IP# Or with interactive promptsudo pptpclient --nolaunchpppd SERVER_IP username PASSWORD# Create connection```bash### Setup PPTP Connection## 🔌 PPTP (Command Line)```sudo pkill openvpn# Kill OpenVPN process```bash### Disconnect```ip addr show | grep tun# Check if connected```bash### View OpenVPN Status```passwordusername```where `credentials.txt` contains:```sudo openvpn --config config.ovpn --auth-user-pass credentials.txt# If credentials are needed```bash### OpenVPN with Authentication```sudo openvpn --daemon --config /path/to/config.ovpn --log /var/log/openvpn.log# Run in backgroundsudo openvpn --config /path/to/config.ovpn# Connect to OpenVPN config file```bash### Basic Connection## 📋 OpenVPN (Command Line)6. Save and connect5. Enter your VPN provider's details   - PPTP   - L2TP/IPSec   - OpenVPN4. Choose VPN type:3. Click "+" to add new connection2. Select "Edit Connections..."1. Click the network icon in the system tray### Add VPN Connection via GUI```nm-applet# Or launch directly:# Click the network icon in your system tray```bash### Access the GUIThe easiest way to manage VPNs is through the NetworkManager GUI applet:## 🚀 GUI VPN Manager (Recommended)- **NetworkManager GUI** - Graphical interface for managing all VPN connections- **WireGuard** - Modern, high-performance VPN (bonus)- **L2TP/IPSec** - Layer 2 Tunneling Protocol with encryption- **PPTP** - Point-to-Point Tunneling Protocol (legacy, less secure)- **OpenVPN** - Industry standard VPN protocol## 🔒 VPN Clients IncludedYour NixOS configuration now includes VPN client support with multiple protocols and a GUI client.
  inputs = {
    # Core Nix packages
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Home Manager for user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # # Nixvim for Neovim configuration
    # nixvim.url = "github:nix-community/nixvim/nixos-25.11";

    # Code formatter
    alejandra.url = "github:kamadorueda/alejandra";

    # Desktop environment and utilities
    ags = {
      type = "github";
      owner = "aylur";
      repo = "ags";
      ref = "v1";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Commented out: Hyprland development version
    # hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ags,
    alejandra,
    nix-flatpak,
    ...
  }: let
    inherit (self) outputs;

    # System configuration
    system = "x86_64-linux";
    host = "msi";
    username = "jay";

    # Package sets
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit system inputs username host;
        };

        modules = [
          ./hosts/${host}/config.nix

          # Modules
          ./modules/overlays.nix # Nixpkgs overlays (CMake policy fixes)
          ./modules/quickshell.nix # Quickshell module
          ./modules/packages.nix # Software packages
          ./modules/fonts.nix # Fonts packages
          ./modules/portals.nix # Portal configuration
          ./modules/theme.nix # Set dark theme
          ./modules/ly.nix # Ly display manager with matrix animation
          ./modules/nh.nix # Nix helper

          # Development languages
          ./modules/php.nix # PHP with Laravel support
          ./modules/nodejs.nix # Node.js with npm/yarn/pnpm
          ./modules/python.nix # Python 3 development

          # Networking
          ./modules/vpn.nix # VPN clients (OpenVPN, PPTP, L2TP) with GUI

          nix-flatpak.nixosModules.nix-flatpak
          # External modules
          inputs.catppuccin.nixosModules.catppuccin

          # Home Manager integration
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-bak";

              # Pass flake inputs to Home Manager
              extraSpecialArgs = {
                inherit inputs system username host;
              };

              users.${username} = {
                home = {
                  username = username;
                  homeDirectory = "/home/${username}";
                  stateVersion = "25.11";
                };

                # Import Home Manager modules
                imports = [
                  ./modules/home/default.nix
                ];
              };
            };
          }

          # Nixpkgs configuration
          {
            nixpkgs.config = {
              allowUnfree = true;
              allowBroken = true; # Temporary fix for broken CUDA in nixos-unstable
              permittedInsecurePackages = [
                "broadcom-sta-6.30.223.271-59-6.18.3"
              ];
            };
          }
        ];
      };
    };

    # Code formatter
    formatter.${system} = alejandra.defaultPackage.${system};
  };
}
