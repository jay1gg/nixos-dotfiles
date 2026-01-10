# Wine - Windows Compatibility Layer
# Allows running Windows applications on Linux
{pkgs, config, username, ...}: {
  environment.systemPackages = with pkgs; [
    # Core Wine packages
    wineWowPackages.stable            # Wine 64-bit support for modern Windows apps
    winetricks        # Script to install Windows components (fonts, libraries)
    
    # Graphics libraries for Direct3D support
    dxvk              # DirectX 12-11 implementation using Vulkan
    vkd3d             # Direct3D 12 support using Vulkan
    
    # Proton/Steam compatibility
    protontricks      # Install Windows libraries in Proton prefixes (for Steam)
  ];
  
  # Wine environment configuration
  # Sets default Wine prefix location
  environment.variables = {
    WINE_DIR = "/home/${username}/.wine";  # Default Wine prefix directory
  };
}
