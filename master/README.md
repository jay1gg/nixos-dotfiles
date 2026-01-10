# NixOS Dotfiles 

A complete NixOS configuration using Nix Flakes with Home Manager, featuring a Hyprland desktop environment setup.

## 📋 Structure

```
├── flake.nix              # Flake configuration (main entry point)
├── flake.lock             # Locked dependency versions
├── hosts/                 # Per-host configurations
│   ├── msi/               # MSI host configuration
│   └── default/           # Default host configuration
└── modules/               # Reusable NixOS & Home Manager modules
    ├── home/              # Home Manager modules
    ├── *.nix              # System-level modules (drivers, packages, etc.)
    └── overlays.nix       # Custom package overlays
```

## 🚀 Quick Start

### Prerequisites
- NixOS installed with Flakes enabled
- Git

### Installation

1. Clone the repository:
```bash
git clone <your-repo-url> ~/nixos-dotfiles
cd ~/nixos-dotfiles/master
```

2. For MSI system:
```bash
sudo nixos-rebuild switch --flake .#msi
```

For default system:
```bash
sudo nixos-rebuild switch --flake .#default
```

## 📦 What's Included

### Desktop Environment
- **Hyprland** - Wayland window manager
- **Waybar** - Status bar
- **Quickshell** - System customization
- **Cava** - Audio visualizer
- **Swaync** - Notification daemon
- **Foot** - GPU-accelerated terminal
- **Hyprlock** - Screen lock

### CLI Tools
- **Ghostty** - Terminal emulator
- **Tmux** - Terminal multiplexer
- **Zsh** - Shell
- **Eza** - Modern `ls` replacement
- **Btop** - System monitor
- **Bat** - Syntax-highlighted cat
- **Tealdeer** - Fast tldr client
- **FZF** - Fuzzy finder
- **Git** - Version control

### System Features
- AMD/NVIDIA driver support
- Catppuccin theme integration
- Flatpak support
- Custom font configuration
- Xwayland support
- OBS virtual camera support

## 🔧 Configuration

### Variables
Edit `hosts/{msi,default}/variables.nix` to customize:
- Keyboard layout
- Locale settings
- System-specific options

### Home Manager
User-level configuration is in `modules/home/`:
- Terminal configurations
- CLI tool settings
- XDG config file mappings

### Packages
System packages are managed in `modules/packages.nix`

## 📝 Development

### Enter development shell:
```bash
nix flake show      # View available configurations
nix flake check     # Check flake for errors
```

### Code formatting:
```bash
nix fmt .           # Format with alejandra
```

## 🐛 Known Issues

- `allowBroken = true` temporary workaround for CUDA in nixos-unstable
- Broadcom WiFi driver requires permittedInsecurePackages

## 🤝 Contributing

- Follow Nix style conventions
- Format code with `alejandra`
- Document significant changes

## 📄 License

See LICENSE file (if applicable)

## 🔗 Useful Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Flakes Wiki](https://wiki.nixos.org/wiki/Flakes)
- [Hyprland Documentation](https://hyprland.org/)
