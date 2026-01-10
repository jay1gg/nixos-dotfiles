# Python Development Environment
# Provides Python 3 with package management and development tools
{config,pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    python3                      # Python 3 - Latest version
    python3Packages.pip          # PIP - Python package installer
    python3Packages.virtualenv   # Virtualenv - Create isolated Python environments
    python3Packages.ipython      # IPython - Enhanced interactive Python shell
    ruff                         # Ruff - Fast Python linter and formatter (Rust-based)
  ];

  # Python environment configuration
  environment.variables = {
    PYTHON = "${pkgs.python3}/bin/python3";          # Default Python executable
  };
}
