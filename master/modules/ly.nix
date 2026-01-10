# Ly Display Manager Configuration
# Minimalist TUI login manager with animated matrix background
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Disable greetd (alternative display manager) by default
  services.greetd.enable = lib.mkDefault false;

  # Ly login manager configuration
  # Provides an alternative to GDM/SDDM with retro aesthetics
  services.displayManager.ly = {
    enable = true;
    settings = {
      hide_f1_commands = true;
      # Available animations: "doom", "colormix", "matrix"
      animation = "matrix";      # Falling characters Matrix-style animation
      bigclock = true;            # Display large clock on login screen
      
      # Color configuration (format: 0xAARRGGBB)
      bg = "0x00000000";          # Dialog background - Black
      fg = "0x0000FFFF";          # Foreground text - Cyan
      border_fg = "0x00FF0000";   # Border color - Red
      error_fg = "0x00FF0000";    # Error text - Red
      clock_color = "#800080";    # Clock color - Purple
      
      default_session = "hyprland";  # Start Hyprland WM by default
      save = true;                   # Remember last login session
    };
  };
}
