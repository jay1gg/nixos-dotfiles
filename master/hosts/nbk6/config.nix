#  https://github.com/jay1gg  #
# Main default config
{
  pkgs,
  host,
  username,
  options,
  ...
}: let
  inherit (import ./variables.nix) keyboardLayout;
in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./packages-fonts.nix
    ../../modules/amd-drivers.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    ../../modules/php.nix # PHP with Laravel support
    ../../modules/nodejs.nix # Node.js with npm/yarn/pnpm
    ../../modules/python.nix # Python 3 development
    ../../modules/databases.nix # Database clients (PostgreSQL, MySQL, MongoDB)
    ../../modules/vpn.nix # VPN clients (OpenVPN, PPTP, L2TP) with GUI
    ../../modules/wine.nix # Wine for running Windows applications
  ];

  # BOOT related stuff
  boot = {
    kernelPackages = pkgs.linuxPackages_latest; # Kernel

    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" # this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" # watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" # watchdog for Intel
    ];

    # This is for OBS Virtual Cam Support
    kernelModules = [ "v4l2loopback" "iwlwifi" ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=1
    '';
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [];
    };

    # Needed For Some Steam Games
    kernel.sysctl = {
     "vm.max_map_count" = 2147483642;
    };

    ## BOOT LOADERS: NOTE USE ONLY 1. either systemd or grub
    # Bootloader SystemD
    loader.systemd-boot.enable = false;

    loader.efi = {
      efiSysMountPoint = "/boot/efi";
      canTouchEfiVariables = true;
    };

    loader.timeout = 5;

    # Bootloader GRUB
    loader.grub = {
    enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      gfxmodeBios = "auto";
      memtest86.enable = true;
      extraGrubInstallArgs = [ "--bootloader-id=${host}" ];
      configurationName = "${host}";
    };

    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };
    
    plymouth.enable = true;
  };
  # Extra Module Options
  drivers = {
    amdgpu.enable = false;
    intel.enable = true;
    nvidia.enable = false;
    nvidia-prime = {
      enable = false;
      intelBusID = "";
      nvidiaBusID = "";
    };
  };
  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  # networking
  networking = {
    networkmanager.enable = true;
    hostName = "${host}";
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
  };

  # Set your time zone.
  services.automatic-timezoned.enable = false; # based on IP location
  time.timeZone = "Asia/Jakarta";

  #https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Services to start
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };

    smartd = {
      enable = false;
      autodetect = true;
    };

    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    #pulseaudio.enable = false; #unstable
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    libinput.enable = true;

    rpcbind.enable = true;
    nfs.server.enable = false;

    openssh.enable = true;

    blueman.enable = true;

    fwupd.enable = true;

    upower.enable = true;

    gnome.gnome-keyring.enable = true;

  };

  environment.systemPackages = [ pkgs.flatpak ];
  services.flatpak = {
    enable = true;
    packages = [ "us.zoom.Zoom" ];
    update.auto.enable = false;
    uninstallUnmanaged = false;
  };
  xdg.portal.enable = true;
  # zram
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };
  # hardware.enableRedistributableFirmware = true;
  services.pulseaudio.enable = false; # stable branch

   # Enable the Docker service
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.setSocketVariable = true;

  # Bluetooth
  hardware = {
     bluetooth = {
       enable = true;
       powerOnBoot = true;
       settings = {
         General = {
           Enable = "Source,Sink,Media,Socket";
           Experimental = true;
         };
       };
     };
   };

  # Security / Polkit
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    polkit.extraConfig = ''
       polkit.addRule(function(action, subject) {
         if (
           subject.isInGroup("users")
             && (
               action.id == "org.freedesktop.login1.reboot" ||
               action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
               action.id == "org.freedesktop.login1.power-off" ||
               action.id == "org.freedesktop.login1.power-off-multiple-sessions"
             )
           )
         {
           return polkit.Result.YES;
         }
      })
    '';
  };
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # OpenGL
  hardware.graphics = {
    enable = true;
  };

  console.keyMap = "us";

  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.QML_IMPORT_PATH = "${pkgs.hyprland-qt-support}/lib/qt-6/qml";
  system.stateVersion = "24.11"; # Did you read the comment?
}
