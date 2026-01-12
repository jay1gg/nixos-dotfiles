# Home Manager configuration
# Manages user-level dotfiles and application settings
{config, pkgs, ...}: 
let
  # Path to git-tracked dotfiles (e.g., hyprland, waybar configs)
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  
  # Path to large/binary files stored outside git (icons, themes, fonts)
  storeDir = "${config.home.homeDirectory}/nixos-dotfiles/store";
  
  # Helper to create symlinks from nix store to user home
  # Allows dotfiles to be modified without rebuilding
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # XDG config files to symlink from dotfiles directory
  # Maps application name to relative path in config/
  configs = {
    cava = "cava";            # Audio visualizer config
    waybar = "waybar";        # Status bar config
    Code = "Code";            # VS Code settings
    hypr = "hypr";            # Hyprland WM config
    swaync = "swaync";        # Notification daemon
    wlogout = "wlogout";      # Logout menu
    "gtk-3.0" = "gtk-3.0";  # GTK3 app themes
    Thunar = "Thunar";        # File manager settings
    xfce4 = "xfce4";        # Xfce4 settings (used by Thunar)
    fastfetch = "fastfetch";  # System info tool
  };

  # Large binary files (icons, themes) from store directory
  storeFiles = {
    ".icons" = ".icons";      # Cursor and icon themes
    ".themes" = ".themes";    # GTK themes
    ".zshrc" = ".zshrc";    # Zsh configuration

  };
in
{
  # Home Manager module imports
  # Each module configures a specific tool or application
  imports = [
    # Terminal multiplexers and emulators
    ./terminals/tmux.nix
    ./terminals/ghostty.nix
    
    # CLI tools for enhanced productivity
    ./cli/bat.nix           # Better cat with syntax highlighting
    ./cli/btop.nix          # System monitor
    ./cli/eza.nix           # Modern ls replacement
    ./cli/fzf.nix           # Fuzzy finder
    ./cli/git.nix           # Git configuration
    ./cli/htop.nix          # Process monitor
    ./cli/tealdeer.nix      # Man page alternative
    
    # Development tools
    ./dev-tools.nix         # PHP, Node.js, Python tools
    
    # Desktop environment
    ./overview.nix          # Overview/dashboard application
    
    # Disabled modules (uncomment to enable)
    # ./editors/nixvim.nix  # Neovim configuration
    # ./cli/bottom.nix      # Alternative to btop
    # ./yazi                # File manager (use Thunar instead)
  ];

  # XDG config files symlinked to dotfiles
  # Changes to dotfiles are immediately reflected (no rebuild needed)
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
  
  # Home directory files symlinked from store directory
  # Used for large or binary files not tracked in git
  home.file = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${storeDir}/${subpath}";
      recursive = true;
    })
    storeFiles;
}
