{
  description = "Jay's nixos-dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra.url = "github:kamadorueda/alejandra";

    ags = {
      type = "github";
      owner = "aylur";
      repo = "ags";
      ref = "v1";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-flatpak,
    home-manager,
    alejandra,
    ...
  }:
  let
    system = "x86_64-linux";
    username = "jay";

    # ---------------- Host factory ----------------
    mkHost = { hostName, extraModules ? [ ] }:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system inputs username;
          host = hostName;
        };

        modules =
          [
            # Host-specific base config
            ./hosts/${hostName}/config.nix

            # Shared modules
            ./modules/overlays.nix
            ./modules/quickshell.nix
            ./modules/packages.nix
            ./modules/fonts.nix
            ./modules/portals.nix
            ./modules/theme.nix
            ./modules/ly.nix
            ./modules/nh.nix

            nix-flatpak.nixosModules.nix-flatpak
            inputs.catppuccin.nixosModules.catppuccin

            # Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hm-bak";

                extraSpecialArgs = {
                  inherit inputs system username;
                  host = hostName;
                };

                users.${username} = {
                  home = {
                    username = username;
                    homeDirectory = "/home/${username}";
                    stateVersion = "25.11";
                  };

                  imports = [
                    ./modules/home/default.nix
                  ];
                };
              };
            }
          ]
          ++ extraModules;
      };
  in
  {
    nixosConfigurations = {
      msi = mkHost {
        hostName = "msi";
        extraModules = [
          {
            nixpkgs.config = {
              allowUnfree = true;
              allowBroken = true;
              permittedInsecurePackages = [
                "broadcom-sta-6.30.223.271-59-6.18.3"
              ];
            };
          }
        ];
      };

      nbk6 = mkHost {
        hostName = "nbk6";
        # no extra nixpkgs hacks here
      };
      vm = mkHost {
        hostName = "vm";
        # no extra nixpkgs hacks here
      };
    };

    formatter.${system} = alejandra.defaultPackage.${system};
  };
}
