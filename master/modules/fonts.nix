# System Fonts Configuration
# Provides comprehensive font coverage for development, UI, and special characters
{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # Core system fonts
      dejavu_fonts              # DejaVu - High quality general-purpose fonts
      noto-fonts                # Noto - Google's universal font collection
      noto-fonts-monochrome-emoji  # Emoji support (black & white)
      noto-fonts-color-emoji    # Emoji support (colored)
      noto-fonts-cjk-sans       # Asian characters (Chinese, Japanese, Korean) - sans-serif
      noto-fonts-cjk-serif      # Asian characters - serif
      
      # Monospace coding fonts
      fira-code                 # Fira Code - Programming font with ligatures
      fira-code-symbols         # Additional symbols for Fira Code
      jetbrains-mono            # JetBrains Mono - Professional coding font
      hackgen-nf-font           # HackGen - Japanese coding font
      roboto-mono               # Roboto Mono - Clean monospace
      victor-mono               # Victor Mono - Stylish coding font
      maple-mono.NF             # Maple Mono - Nerd Font variant
      terminus_font             # Terminus - Low-level bitmap font
      
      # Sans-serif fonts
      inter                     # Inter - Carefully crafted sans-serif
      roboto                    # Roboto - Google's modern sans-serif
      ibm-plex                  # IBM Plex - Professional IBM font family
      
      # Icon and symbol fonts
      font-awesome              # Font Awesome - Icon font
      material-icons            # Material Design Icons
      powerline-fonts           # Powerline - Shell prompt symbols
      symbola                   # Symbola - Unicode symbol coverage
      
      # Specialty fonts
      minecraftia               # Minecraft - Blocky pixel font
      
      # Nerd Fonts variants (monospace + glyphs for terminal)
      nerd-fonts.im-writing     # Nerd Font variant: IM Writing
      nerd-fonts.blex-mono      # Nerd Font variant: IBM Plex Mono patched
    ];
  };
}
