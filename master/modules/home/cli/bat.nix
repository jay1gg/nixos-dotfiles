# Bat - Better `cat` with syntax highlighting
# Replaces cat with color output, git integration, and line numbers
{
  pkgs,
  lib,
  ...
}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";        # Use less pager with Raw color support
      style = "full";            # Show all style elements
      # Alternative styles: numbers,changes,headers,rule,grid
      # Available themes: Dracula, Catppuccin, GitHub, Nord, Solarized, etc.
      theme = lib.mkForce "Dracula";
    };
    # Extra bat utilities
    extraPackages = with pkgs.bat-extras; [
      batman           # Man page viewer using bat
      batpipe          # Syntax highlight using bat in pipes
    ];
  };
  
  # Use bat as man page pager for colored output
  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";  # Pipe man to bat for coloring
    MANROFFOPT = "-c";                               # Disable bold in man pages
  };
}
