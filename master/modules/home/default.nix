{config, pkg, ...}: 
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  storeDir = "${config.home.homeDirectory}/nixos-dotfiles/store";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    cava = "cava";
    waybar = "waybar";
    Code = "Code";
    hypr = "hypr";
    swaync = "swaync";
    wlogout = "wlogout";
    foot = "foot";

  };

  storeFiles = {
  ".icons" = ".icons";
  ".themes" = ".themes";
  };
in
{
  imports = [
    ./terminals/tmux.nix
    ./terminals/ghostty.nix
    ./editors/nixvim.nix
    ./cli/bat.nix
    ./cli/btop.nix
    # ./cli/bottom.nix
    ./cli/eza.nix
    ./cli/fzf.nix
    ./cli/git.nix
    ./cli/htop.nix
    ./cli/tealdeer.nix
    # ./yazi
    ./overview.nix
  ];

    # Iterate over xdg configs and map them accordingly
    xdg.configFile = builtins.mapAttrs (name: subpath: {
        source = create_symlink "${dotfiles}/${subpath}";
        recursive = true;
    }) configs;
  ## ~/*
  home.file = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${storeDir}/${subpath}";
      recursive = true;
    })
    storeFiles;
}
