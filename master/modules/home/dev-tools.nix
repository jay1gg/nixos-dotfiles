# Development tools configuration
# Code quality, formatting, and testing tools
{pkgs, ...}: {
  home.packages = with pkgs; [
    # JavaScript/TypeScript development tools
    nodePackages.prettier          # Code formatter for JS/TS/JSON/CSS
    nodePackages.eslint            # Linter to find and fix JS problems
    nodePackages.typescript        # TypeScript compiler and language support

    # Python development tools
    python3Packages.black          # Code formatter for Python (PEP 8 compliant)
    python3Packages.pylint         # Static analysis tool for Python code
    python3Packages.mypy           # Static type checker for Python
    python3Packages.pytest         # Testing framework for Python

    # General development utilities
    git-lfs                        # Git Large File Storage for binary files
  ];

  # Environment variables for development
  home.sessionVariables = {
    EDITOR = "nano";               # Default text editor (set to vi for minimal systems)
  };
}
