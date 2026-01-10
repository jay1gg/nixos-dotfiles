# NixOS Configuration Modules Guide

This document provides an overview of all configuration modules and their purposes.

## System Modules

### Core System Configuration

- **[hosts/msi/config.nix](hosts/msi/config.nix)** - Main system configuration
  - Boot configuration (kernel, GRUB, EFI)
  - Networking and display manager
  - Audio (PipeWire), Bluetooth, GPU support
  - Services (SSH, NFS, fwupd, etc.)
  - Security settings (Polkit, PAM)
  - Nix optimization and garbage collection

### GPU & Hardware Drivers

- **[modules/amd-drivers.nix](modules/amd-drivers.nix)** - AMD GPU drivers (AMDGPU, ROCM)
- **[modules/nvidia-drivers.nix](modules/nvidia-drivers.nix)** - NVIDIA GPU drivers
- **[modules/nvidia-prime-drivers.nix](modules/nvidia-prime-drivers.nix)** - Hybrid GPU (Intel + NVIDIA)
- **[modules/intel-drivers.nix](modules/intel-drivers.nix)** - Intel GPU drivers

### Desktop Environment

- **[modules/packages.nix](modules/packages.nix)** - System packages and programs
  - Hyprland window manager configuration
  - Desktop utilities (Waybar, Rofi, Swaynotificationcenter)
  - Software packages organized by category
  - Custom shell scripts (update, rebuild, ncg)

- **[modules/theme.nix](modules/theme.nix)** - System theme and appearance
  - GTK/Qt theme configuration
  - Cursor themes
  - Dark mode preferences (dconf)
  - Icon themes (Papirus, Adwaita)

- **[modules/fonts.nix](modules/fonts.nix)** - System font packages
  - Monospace fonts for coding (Fira Code, JetBrains Mono, etc.)
  - Icon fonts (Font Awesome, Material Icons)
  - CJK fonts for Asian character support
  - Nerd Fonts for terminal glyphs

### Display & Login Manager

- **[modules/ly.nix](modules/ly.nix)** - Ly display manager
  - Minimalist TUI login screen
  - Matrix falling characters animation
  - Customizable colors and appearance

### Desktop Utilities

- **[modules/quickshell.nix](modules/quickshell.nix)** - Quickshell desktop framework
  - Qt6-based custom shell/panels
  - QML UI integration
  - Wayland support

- **[modules/portals.nix](modules/portals.nix)** - XDG Desktop Portals
  - File picker and screen sharing
  - Hyprland portal integration

- **[modules/overlays.nix](modules/overlays.nix)** - Nixpkgs overlays
  - CMake policy fixes
  - Package customizations

## Development Languages & Tools

### Programming Languages

- **[modules/php.nix](modules/php.nix)** - PHP 8.4 with Composer
  - Laravel development support
  - PHP CLI tools

- **[modules/nodejs.nix](modules/nodejs.nix)** - Node.js 20 LTS
  - npm, yarn, pnpm package managers
  - Corepack for version management

- **[modules/python.nix](modules/python.nix)** - Python 3 development
  - pip, virtualenv, IPython
  - Ruff linter/formatter
  - Development tools

### Development Tools

- **[modules/databases.nix](modules/databases.nix)** - Database clients
  - DBeaver universal database tool
  - Optional: PostgreSQL, MySQL, MongoDB, Redis, SQLite

- **[modules/vpn.nix](modules/vpn.nix)** - VPN clients
  - OpenVPN with NetworkManager integration
  - L2TP/IPSec support
  - WireGuard tools
  - Kernel modules for VPN protocols

- **[modules/wine.nix](modules/wine.nix)** - Wine Windows compatibility
  - 32-bit and 64-bit Wine support
  - DirectX support (DXVK, VKD3D)
  - Proton/Steam compatibility

## Home Manager Modules

### CLI Tools & Shells

- **[modules/home/cli/bat.nix](modules/home/cli/bat.nix)** - Bat (better cat)
  - Syntax highlighting
  - Git integration
  - Man page coloring

- **[modules/home/cli/eza.nix](modules/home/cli/eza.nix)** - Eza (modern ls)
  - Colorful file listing
  - Git status integration
  - Tree view support

- **[modules/home/cli/fzf.nix](modules/home/cli/fzf.nix)** - Fuzzy finder
  - Command-line fuzzy search
  - Catppuccin Mocha theme
  - File, history, and argument search

- **[modules/home/cli/btop.nix](modules/home/cli/btop.nix)** - System monitor
  - Process monitoring
  - GPU support (CUDA, ROCm)

- **[modules/home/cli/bottom.nix](modules/home/cli/bottom.nix)** - System monitor (alternative)

- **[modules/home/cli/htop.nix](modules/home/cli/htop.nix)** - Process monitor

- **[modules/home/cli/git.nix](modules/home/cli/git.nix)** - Git configuration
  - Git aliases and settings
  - Delta git pager integration
  - Credential management

- **[modules/home/cli/tealdeer.nix](modules/home/cli/tealdeer.nix)** - Tealdeer (man page alternative)

### Development Tools

- **[modules/home/dev-tools.nix](modules/home/dev-tools.nix)** - Development tools
  - Node.js tools (Prettier, ESLint, TypeScript)
  - Python tools (Black, Pylint, Mypy, Pytest)
  - Git LFS

### Terminals

- **[modules/home/terminals/tmux.nix](modules/home/terminals/tmux.nix)** - Tmux terminal multiplexer

- **[modules/home/terminals/ghostty.nix](modules/home/terminals/ghostty.nix)** - Ghostty terminal emulator

### Editors

- **[modules/home/editors/nixvim.nix](modules/home/editors/nixvim.nix)** - Neovim configuration (commented out)

### Desktop Shell

- **[modules/home/overview.nix](modules/home/overview.nix)** - Overview/dashboard application

- **[modules/home/default.nix](modules/home/default.nix)** - Home Manager main configuration
  - Module imports and organization
  - Symlink management for dotfiles

### File Manager

- **[modules/home/yazi/](modules/home/yazi/)** - Yazi file manager configuration
  - Keybindings, themes, and plugins

## System Services & Helpers

- **[modules/nh.nix](modules/nh.nix)** - Nh (Nix helper) utility
- **[modules/local-hardware-clock.nix](modules/local-hardware-clock.nix)** - Hardware clock configuration
- **[modules/vm-guest-services.nix](modules/vm-guest-services.nix)** - Virtualization guest tools
- **[modules/packages-fonts.nix](hosts/*/packages-fonts.nix)** - Per-host font configuration
- **[modules/users.nix](hosts/*/users.nix)** - User account configuration
- **[modules/variables.nix](hosts/*/variables.nix)** - Host-specific variables

## Configuration Files

### Main Configuration

- **[flake.nix](flake.nix)** - Flake configuration
  - Input definitions (nixpkgs, home-manager, etc.)
  - NixOS system declaration
  - Module imports
  - System variables (hostname, username, system arch)

- **[README.md](README.md)** - Project documentation

- **[DEV_SETUP.md](DEV_SETUP.md)** - Development tools quick start guide

## Usage

### Enable a Module

Add to `flake.nix` in the modules list:
```nix
./modules/module-name.nix
```

### Rebuild System

```bash
sudo nixos-rebuild switch --flake ~/nixos-dotfiles/master
# or use custom script:
update
```

### Enable Optional Modules

Uncomment lines in relevant configuration files (marked with `#`).

### Customize per Host

Edit host-specific files in `hosts/{hostname}/`:
- `config.nix` - Main configuration
- `hardware.nix` - Hardware-specific settings
- `users.nix` - User accounts
- `packages-fonts.nix` - Fonts
- `variables.nix` - Variables (keyboard layout, etc.)

## Quick Reference

| Module | Purpose | Default |
|--------|---------|---------|
| PHP | Laravel development | ✅ Enabled |
| Node.js | JavaScript/TypeScript | ✅ Enabled |
| Python | Python development | ✅ Enabled |
| Wine | Windows apps | ✅ Enabled |
| VPN | OpenVPN/L2TP/WireGuard | ✅ Enabled |
| Databases | Database clients | ⚠️ DBeaver only |
| Hyprland | Window manager | ✅ Enabled |
| Ly | Login manager | ✅ Enabled |
| Quickshell | Desktop shell | ✅ Enabled |

---

*Last updated: January 10, 2026*
