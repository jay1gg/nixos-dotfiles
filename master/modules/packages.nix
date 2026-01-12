{ pkgs
, pkgs-oldstable
, inputs
, host
, ...
}: {

  # Services
  services.power-profiles-daemon.enable = true;

  # Programs
  programs = {
    # Window manager and desktop environment
    hyprland = {
      enable = true;
      withUWSM = false;
      portalPackage = pkgs.xdg-desktop-portal-hyprland; # xdph none git
      xwayland.enable = true;
    };

    # Shell
    zsh.enable = true;

    # Browsers
    firefox.enable = false;

    # Status bars (waybar started by Hyprland dotfiles)
    waybar.enable = false; # Enabling causes two waybars

    # Screen lockers
    hyprlock.enable = true;

    # Desktop utilities
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;

    # Security
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Version control
    git.enable = true;

    # Terminal multiplexers
    tmux.enable = true;

    # Network
    nm-applet.indicator = true;

    # # Editors
    # neovim = {
    #   enable = false;
    #   defaultEditor = false;
    # };

    # File managers
    thunar.enable = true;
    thunar.plugins = with pkgs; [
      xfce4-exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];
  };

  # Nixpkgs configuration
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = let
    # Communication
    communicationPackages = with pkgs; [
      telegram-desktop
    ];

    # Development tools
    developmentPackages = with pkgs; [
      alejandra
      cargo
      clang
      cmake
      gcc
      gnumake
      nh
      vscode
    ];

    # Desktop environment packages
    desktopPackages = with pkgs; [
      brightnessctl
      cliphist
      grim
      grimblast
      hyprcursor
      hypridle
      hyprlang
      hyprpolkitagent
      hyprshot
      hyprland-qt-support
      loupe
      mesa
      nwg-displays
      nwg-look
      pyprland
      rofi
      slurp
      swww
      swappy
      swaynotificationcenter
      wallust
      waypaper
      waybar
      wdisplays
      wl-clipboard
      wlogout
      wlr-randr
      yad
      (inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default)
      (inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.default)
    ];

    # Utilities
    utilsPackages = with pkgs; [
      ffmpeg
      figlet
      file-roller
      findutils
      frogmouth
      glib
      gsettings-qt
      jq
      killall
      libnotify
      lolcat
      lsd
      lstr
      macchina
      mcat
      mdcat
      ncdu
      ncftp
      netop
      oh-my-posh
      openssl
      pamixer
      pavucontrol
      pik
      playerctl
      ripgrep
      socat
      starship
      tldr
      trippy
      tuptime
      ugrep
      unrar
      unzip
      v4l-utils
      wget
      xarchiver
      zoxide
      (btop.override {
        cudaSupport = true;
        rocmSupport = true;
      })
      obs-studio
    ];

    # Hardware monitoring
    hardwarePackages = with pkgs; [
      glances
      hyfetch
      ipfetch
      light
      lm_sensors
      mission-center
      smartmontools
    ];

    # Internet and browsers
    internetPackages = with pkgs; [
      google-chrome
    ];

    # Virtualization
    virtualizationPackages = with pkgs; [
      libvirt
      virt-manager
      virt-viewer
    ];

    # Video and media
    videoPackages = with pkgs; [
      vlc
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
    ];

    # Terminals
    terminalsPackages = with pkgs; [
      kitty
      wezterm
    ];

    # Custom scripts
    scripts = [
      (pkgs.writeShellScriptBin "update" ''
          set -e
          HOST="$(cat /etc/hostname)"
          cd ~/nixos-dotfiles/master
          nh os switch -u -H "$HOST" .
      '')
      (pkgs.writeShellScriptBin "rebuild" ''
          set -e
          HOST="$(cat /etc/hostname)"
          cd ~/nixos-dotfiles/master
          sudo nixos-rebuild switch --flake ".#$HOST"
      '')
      (pkgs.writeShellScriptBin "ncg" ''
        nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot
      '')
    ];

    # Special packages
    specialPackages = with pkgs; [
      bc
      baobab
      btrfs-progs
      cava
      cmatrix
      cpufrequtils
      curl
      eog
      fastfetch
      feh
      gnome-system-monitor
      gtk-engine-murrine
      imagemagick
      inxi
      kdePackages.polkit-kde-agent-1
      kdePackages.qt6ct
      kdePackages.qtstyleplugin-kvantum
      kdePackages.qtwayland
      lazydocker
      lazygit
      libappindicator
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      mc
      networkmanagerapplet
      pciutils
      power-profiles-daemon
      serie
    ];
  in
    communicationPackages ++ developmentPackages ++ desktopPackages ++ utilsPackages ++ hardwarePackages ++ internetPackages ++ virtualizationPackages ++ videoPackages ++ terminalsPackages ++ scripts ++ specialPackages;

  # Environment variables
  environment.variables = {
    JAKOS_NIXOS_VERSION = "0.0.5";
    JAKOS = "true";
  };
}
