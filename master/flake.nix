{
  description = "Jay's nixos-dotfiles";
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

          # Wine support
          ./modules/wine.nix # Wine for running Windows applications

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
