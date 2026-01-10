{pkgs, ...}: {
  # Python 3 with development tools
  environment.systemPackages = with pkgs; [
    python3 # Python 3
    python3Packages.pip # Package installer
    python3Packages.virtualenv # Virtual environments
    python3Packages.ipython # Enhanced Python shell
    ruff # Fast Python linter and formatter
  ];

  # Python environment
  environment.variables = {
    PYTHON = "${pkgs.python3}/bin/python3";
    PYTHONPATH = "\${HOME}/.local/lib/python3.12/site-packages";
  };
}
