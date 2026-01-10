{pkgs, ...}: {
  # Development tools configuration
  home.packages = with pkgs; [
    # Node.js development tools
    nodePackages.prettier # Code formatter
    nodePackages.eslint # JavaScript linter
    nodePackages.typescript # TypeScript support

    # Python development tools
    python3Packages.black # Python formatter
    python3Packages.pylint # Python linter
    python3Packages.mypy # Python static type checker
    python3Packages.pytest # Python testing framework

    # General development
    git-lfs # Git Large File Storage
  ];

  # Home directory variables for development
  home.sessionVariables = {
    EDITOR = "nano"; # Set preferred editor
  };
}
