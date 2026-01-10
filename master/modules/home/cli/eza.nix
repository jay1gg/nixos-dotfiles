# Eza - Modern `ls` Replacement
# Fast, colorful file/directory listing with git integration
{
  programs.eza = {
    enable = true;
    icons = "auto";              # Show icons when terminal supports it
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    git = true;                  # Show git status for files

    extraOptions = [
      "--group-directories-first"  # Folders before files
      "--no-quotes"                # Don't quote filenames
      "--header"                   # Show header row with column names
      "--git-ignore"               # Respect .gitignore
      # "--time-style=long-iso"    # ISO 8601 extended format (YYYY-MM-DD)
      "--classify"                 # Append type indicator (/, *, =, @, |)
      "--hyperlink"                # Make paths clickable in some terminals
    ];
  };
  
  # Shell aliases to replace ls with eza
  home.shellAliases = {
    ":q" = "exit";               # Vim-style exit
    c = "clear";                 # Clear screen
    ls = "eza";                  # Replace ls with eza
    lt = "eza --tree --level=2"; # Tree view (2 levels deep)
    ll = "eza  -a --no-user --long";  # Long format listing
    la = "eza -lah";             # Long format with hidden files
    lsbc = "lsblk -f | bat -l conf -p";  # Disk layout with colors
    tree = "eza --tree";         # Tree view (all levels)
    d = "exa -a --grid ";
    dir = "exa -a --grid";
    jctl = "journalctl -p 3 -xb";
    ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
    man = "batman";
    dysk = "dysk -c label+default";
    zi = "cdi"; # for zoxide compatibilty
    serie = "serie -p kitty --preload -g double";
    # Terminal client: use the et wrapper (sets TERM to *-direct when available)
    # Remove alias here so the script installed to PATH is used.
  };
}
