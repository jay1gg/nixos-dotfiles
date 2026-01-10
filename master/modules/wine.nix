{pkgs, ...}: {
  # Wine support for running Windows applications
  
  environment.systemPackages = with pkgs; [
    # Wine
    wine # Wine (main package)
    wine64 # Wine 64-bit support
    winetricks # Wine tricks for installing components
    
    # Wine dependencies and utilities
    dxvk # DirectX 12 implementation for Wine
    d3d12 # Direct3D 12 support
    
    # GUI utilities
    protontricks # Proton tricks for compatibility
  ];

  # Enable 32-bit support for Wine compatibility
  nixpkgs.config.allowUnfree = true;
  
  # Wine environment configuration
  environment.variables = {
    WINE_DIR = "/home/jay/.wine";
  };
}
