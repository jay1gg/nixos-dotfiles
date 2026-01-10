{pkgs, config, username, ...}: {
  # Wine support for running Windows applications
  
  environment.systemPackages = with pkgs; [
    # Wine
    wine # Wine (main package)
    wine64 # Wine 64-bit support
    winetricks # Wine tricks for installing components
    
    # Wine dependencies and utilities
    dxvk # DirectX 12 implementation for Wine
    vkd3d # Direct3D 12 support
    
    # GUI utilities
    protontricks # Proton tricks for compatibility
  ];
  
  # Wine environment configuration
  environment.variables = {
    WINE_DIR = "/home/${username}/.wine";
  };
}
