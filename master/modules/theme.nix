{
  pkgs,
  lib,
  config,
  ...
}: {
  # System Theme Configuration
  # Sets GTK/Qt themes, cursor, icons, and dark mode preferences
  
  # Install theme packages
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme      # GNOME Adwaita icon theme
    papirus-icon-theme      # Papirus - Modern icon theme
    bibata-cursors          # Bibata - Modern cursor theme
    adwaita-qt              # Qt integration with GTK theme
  ];

  # Fallback environment variables for apps that don't read dconf
  # Avoid hard overrides so tools like nwg-look can dynamically change themes
  environment.variables = {
    # GTK2 theming (for legacy GTK2 applications)
    GTK2_RC_FILES = "${pkgs.gnome-themes-extra}/share/themes/Adwaita-dark/gtk-2.0/gtkrc";
    # Qt5/Qt6 apps follow GTK theme via XDG portal
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  # Cursor theme for XDG/Wayland sessions
  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";  # Cursor theme name
    XCURSOR_SIZE = "24";                      # Cursor size in pixels
  };

  # System-wide dconf defaults (theme, dark mode preference)
  # New users get these defaults; they can override with gsettings
  environment.etc = {
    "dconf/profile/user".text = ''
      user-db:user
      system-db:local
    '';
    "dconf/db/local.d/00_theme".text = ''
      [org/gnome/desktop/interface]
      color-scheme='prefer-dark'
      gtk-theme='Adwaita-dark'
      icon-theme='Papirus-Dark'
      cursor-theme='Bibata-Modern-Classic'
    '';
  };

  # Rebuild the dconf database at activation to apply system defaults
  system.activationScripts.dconfUpdate = {
    # Ensure /etc is populated (including /etc/dconf/...) before running dconf update
    deps = ["etc"];
    text = ''
      if [ -x ${pkgs.dconf}/bin/dconf ]; then
        if [ -d /etc/dconf/db ]; then
          ${pkgs.dconf}/bin/dconf update || true
        fi
      fi
    '';
  };
}
