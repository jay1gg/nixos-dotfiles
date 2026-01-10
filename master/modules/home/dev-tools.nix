{pkgs, ...}: {
  # Development tools configuration
  home.packages = with pkgs; [
    # Laravel-specific tools
    laravel-pail # Laravel log viewer
    
    # Node.js development tools
    nodePackages.prettier # Code formatter
    nodePackages.eslint # JavaScript linter
    nodePackages.typescript # TypeScript support
    
    # Python development tools
    black # Python formatter
    pylint # Python linter
    mypy # Python static type checker
    pytest # Python testing framework
    
    # General development
    git-lfs # Git Large File Storage
    just # Command runner
  ];

  # Home directory variables for development
  home.sessionVariables = {
    EDITOR = "nano"; # Set preferred editor
  };
}
