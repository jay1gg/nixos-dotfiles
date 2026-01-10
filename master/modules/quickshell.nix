# Quickshell Configuration
# QML-based desktop shell and widget toolkit for Wayland
{
  lib,
  pkgs,
  inputs,
  ...
}: {
  # Install Quickshell and Qt6 dependencies
  environment.systemPackages = with pkgs; [
    # Quickshell - Custom QML shell/panel framework
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Qt6 dependencies required by Quickshell
    qt6.qtbase            # Qt6 core framework
    qt6.qtdeclarative     # QML engine for UI
    qt6.qtwayland         # Wayland protocol support
    qt6.qtsvg             # SVG image support
    qt6.qtmultimedia      # Audio/video support
  ];

  # Qt6 QML module paths
  # Allows QML to find Qt modules during runtime
  environment.variables = {
    QML2_IMPORT_PATH = lib.mkDefault "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml";
  };

  # Qt configuration for Wayland sessions
  # Ensures Qt applications use native Wayland instead of fallback X11
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";            # Prefer Wayland, fallback to X11
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";  # Use WM decorations instead of Qt's
  };
}
