# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs
, inputs
, ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # ./guh-nome.nix
    ./Hyprland.nix
    # ./vm.nix
    # ./guac.nix
    ./extraneous-pkgs.nix
    ./amd.nix
    # ./style.nix
    ./syncthing.nix
    # ./nixvim/nixvim.nix
    # ./minecraft-server.nix
    # ./nvf/nvf-config.nix
    # ./vm-passthrough.nix # DONT USE
    # ./virtual-machine.nix
    ./speaking-of-guacamole/guac.nix
    ./hacking/intermediary.nix
    # ./nxtvim
    # ./wine.nix
  ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  time.hardwareClockInLocalTime = true;
  # Boot loader
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      enable = true;
      efiSupport = true;
      useOSProber = true;
      extraEntries = ''
        menuentry "Reboot to Firmware Setup" {
          fwsetup
        }
      '';
      configurationLimit = 36;
      # theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze";
    };
    timeout = null;
  };

  networking.hostName = "alpha-compooper"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

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

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us,es";
    xkb.variant = "";
    enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.saltcal = {
    isNormalUser = true;
    description = "Sal Cali";
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
    ];
    # packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.zsh;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.git = {
    enable = true;
    config = {
      user.name = "SalC124";
      user.email = "Saltcal124@gmail.com";
      init = {
        defaultBranch = "main";
      };
      safe.directory = "*";

    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    histSize = 10000;
    histFile = "~/.zsh_history";
    autosuggestions.async = true;

    # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    promptInit = ''
      eval "$(starship init zsh)"
      eval "$(zoxide init --cmd cd zsh)"
    ''; # eval "$(zellij setup --generate-auto-start zsh)"
    shellAliases = {
      nixedit = "sudo vi /etc/nixos/configuration.nix";
      rebuild = "cd /etc/nixos/ && nh os switch";
      hyprdir = "vi ~/.config/hypr/";
      ytdl = "yt-dlp -f bestvideo+bestaudio --embed-thumbnail --embed-metadata --embed-chapters --write-auto-subs --embed-subs -P '~/Videos/Youtube Downloads'";
      cleanup = "nix-collect-garbage";
      nixdir = "cd /etc/nixos/ && sudo vi ./";
      vs = "cd ~/ && sudo code --no-sandbox --user-data-dir='.config/Code'";
      sysflk = "sudo vi /etc/nixos/flake.nix";
      nvedit = "sudo vi /etc/nixos/nxtvim/";
      kys = ''echo "u too"; systemctl poweroff'';
      brb = ''echo "buh-bye!"; systemctl reboot'';
      eep = ''echo "zzz..."; systemctl sleep'';
      update = "cd /etc/nixos/ && sudo nix flake update";
      ls = "lsd -A";
      yz = "yazi";
      kill-zj = ''zellij kill-all-sessions -y || echo "why dont you read with your eyes?" && zellij delete-all-sessions -y'';
      nv = ''vi ./'';
      envy = ''vi ./'';
      rpi-ws-fs = ''sudo sshfs -o allow_other,default_permissions saltcal@67.84.35.204:/ /media/rp-sd && cd /media/rp-sd/'';
      rpi-ws-ssh = ''kitten ssh saltcal@67.84.35.204'';
      zj = ''zellij'';
      ardwork = ''sudo chmod a+rw /dev/ttyACM0; sudo chmod a+rw /dev/ttyUSB0'';
      py = ''python'';
      nrd = ''npm'';
      battery = ''cat /sys/class/power_supply/BAT1/capacity'';
    };

    ohMyZsh = {
      enable = true;
      plugins = [
        "git" # "nix-shell"
      ];
    };
  };

  xdg.mime.enable = true;
  xdg.mime.defaultApplications = {
    "text/html" = "microsoft-edge.desktop";
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = nixpkgs-: true;
  # nixpkgs.config.nvidia.acceptLicense = true;p

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.nh

    inputs.uncpkgs.microsoft-edge

    inputs.zen-browser.packages.x86_64-linux.twilight
    # inputs.zen-browser.packages.x86_64-linux.twilight.override
    # {
    #   policies = {
    #     DisableAppUpdate = true;
    #     DisableTelemetry = true;
    #     # more and more
    #   };
    # }

    pkgs.ripgrep
    pkgs.fd
    pkgs.zsh-powerlevel10k
    # pkgs.zsh-nix-shell
    pkgs.lshw
    pkgs.ntfs3g
    pkgs.tree
    pkgs.sshfs
    pkgs.p7zip
    pkgs.rar

    pkgs.zoxide
    pkgs.fzf
    pkgs.lsd
    pkgs.yazi
    pkgs.tmux

    pkgs.partimage
    pkgs.gparted
    pkgs.unetbootin
    pkgs.qbittorrent-enhanced
    pkgs.gnome-multi-writer

    pkgs.neofetch
    pkgs.gitFull
    pkgs.gh
    # pkgs.arduino
    pkgs.arduino-ide
    pkgs.arduino-cli
    # pkgs.arduino-core
    # pkgs.arduino-ide
    pkgs.simulide
    # pkgs.vscode-fhs
    pkgs.vscode-fhs
    pkgs.python312
    # pkgs.python312Packages.matplotlib

    pkgs.libgcc
    pkgs.nasm
    pkgs.libgccjit
    pkgs.llvmPackages_latest.llvm
    pkgs.binutils_nogold
    # pkgs.zulu8
    # pkgs.zulu11
    # pkgs.zulu17
    # pkgs.zulu
    pkgs.powershell
    # pkgs.jetbrains.webstorm
    pkgs.jetbrains.idea-ultimate
    pkgs.jetbrains.jdk
    pkgs.jdk
    pkgs.greenfoot
    # vvv dotnet sdk 7.0.410 is insecure vvv
    # pkgs.jetbrains.rider
    # pkgs.jetbrains.rust-rover
    # pkgs.jetbrains.clion
    pkgs.maven
    pkgs.nodejs_22
    pkgs.tailwindcss
    # pkgs.mysql84
    # pkgs.mysql-workbench
    pkgs.android-studio
    pkgs.android-tools
    pkgs.sdkmanager
    pkgs.google-cloud-sdk
    pkgs.flutter
    pkgs.postman
    pkgs.gradle
    pkgs.jupyter-all
    pkgs.kotlin
    # pkgs.kicad
    pkgs.ngspice
    pkgs.logisim-evolution
    pkgs.gnumake

    pkgs.fabric-ai

    # (pkgs.discord.override {
    #   withOpenASAR = true;
    #   withVencord = true;
    # })

    pkgs.vesktop
    # pkgs.discord
    pkgs.whatsapp-for-linux
    pkgs.protonvpn-gui
    pkgs.syncthing
    pkgs.btop
    pkgs.zenith
    pkgs.obsidian
    pkgs.rclone
    # pkgs.piper
    pkgs.yt-dlp
    pkgs.jellyfin-ffmpeg
    pkgs.spotify-player
    pkgs.zoom-us
    pkgs.spotify
    pkgs.spotifyd

    pkgs.onlyoffice-bin_latest
    pkgs.libreoffice
    pkgs.krita
    pkgs.gimp
    pkgs.lightworks
    pkgs.pinta

    pkgs.via
    pkgs.framework-tool
    pkgs.corefonts
    pkgs.ngspice

    pkgs.cbonsai

    # pkgs.waydroid DO NOT INSTALL, JUST FOR REFERENCE

    pkgs.musescore
    pkgs.muse-sounds-manager

    pkgs.weechat

    pkgs.warp-terminal

    pkgs.processing

    # general tso's chicken
    pkgs.bat
    pkgs.eza
    pkgs.ncspot

    # pkgs.rustc
    pkgs.cargo
    pkgs.rustfmt
    pkgs.rustup
    pkgs.gccgo14
    pkgs.wasm-pack
    pkgs.cargo-generate
    pkgs.openssl
    pkgs.wasm-bindgen-cli

    pkgs.trunk
    # pkgs.dioxus-cli
    # pkgs.cargo-tauri

    pkgs.surrealdb

    # esp32 + rust
    pkgs.git
    pkgs.wget
    pkgs.gnumake
    pkgs.flex
    pkgs.bison
    pkgs.gperf
    pkgs.pkg-config
    pkgs.cmake
    pkgs.ncurses5
    pkgs.ninja
    (pkgs.python3.withPackages (p: with p; [
      pip
      virtualenv
    ]))
    pkgs.espflash

    pkgs.gcc-arm-embedded # 13 is broken
    pkgs.unixtools.xxd

    pkgs.rust-analyzer
    pkgs.typescript
    pkgs.lolcat
    pkgs.nixpkgs-fmt

    pkgs.go
    pkgs.cargo-3ds

    (pkgs.writeShellScriptBin "stats" ''
      power="$(cat /sys/class/power_supply/BAT1/capacity)% ($(powerprofilesctl get) mode)"
      
      timestamp="$(date | awk '{for(i=1;i<=NF-2;i++) printf "%s ", $i}')"
      
      net_state="$(nmcli general status | awk 'NR==2 {print $1}')"
      
      net_name="$(nmcli connection show | rg 'wlp2s0' | awk '{for(i=1;i<=NF-3;i++) printf "%s ", $i}' | xargs)" # connection name (bad, i know)
     
      audio="$(pulsemixer --get-volume | awk '{print $1}')%"
      if [ "$(pulsemixer --get-mute)" -eq 1 ]; then
          audio="$audio (muted)"
      fi

      output="$timestamp | $net_state to $net_name | $audio | $power"

      # term_width=$(tput cols)
      # output_len=$(expr length "$output")
      # padding=$(( (term_width - output_len) / 2 ))
      # printf "%*s\n" $((padding + output_len)) "$output"

      echo "$output"
    '')
    (pkgs.writeShellScriptBin "wp" ''
      dir=$HOME/Pictures/Wallpapers/mgs
      current=$(hyprctl hyprpaper listloaded | head -n1)
      list=$(find "$dir" -type f | sort)
      next=
      first=
      found=0
      while IFS= read -r f; do
        [ -z "$first" ] && first=$f
        if [ "$found" = 1 ]; then
          next=$f
          break
        fi
        [ "$f" = "$current" ] && found=1
      done <<EOF
      $list
      EOF
      [ -z "$next" ] && next=$first
      hyprctl hyprpaper reload ,"$next"
    '')
  ];
  programs.nix-ld.enable = true;

  programs.java = {
    enable = true;
    # package = pkgs.temurin-jre-bin-24;
    package = pkgs.zulu24;
    # package = pkgs.oraclejre8;
  };

  programs.direnv = {
    enable = true;
    settings = {
      hide_env_diff = true;
    };
  };

  hardware.keyboard.qmk.enable = true;

  services.udev.packages = [ pkgs.via ];

  programs.adb.enable = true;

  # services.solaar = {
  #   enable = true; # Enable the service
  #   package = pkgs.solaar; # The package to use
  #   window = "hide"; # Show the window on startup (show, *hide*, only [window only])
  #   batteryIcons = "regular"; # Which battery icons to use (*regular*, symbolic, solaar)
  #   extraArgs = ""; # Extra arguments to pass to solaar on startup
  # };

  hardware.uinput.enable = true;

  # services.mysql = {
  #   enable = true;
  #   package = pkgs.mariadb;
  # };

  services.printing.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # x2go vnc server
  # services.x2goserver.enable = true;

  # guacamole vnc server
  # services.guacamole-server = { enable = true; host = "192.168.1.7"; port = 8080; };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 8080 ];
  # networking.firewall.allowedUDPPorts = [ 8080 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  services.ratbagd.enable = true;

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    package = pkgs.ollama-rocm;
    rocmOverrideGfx = "11.0.0";
  };

  # TODO fix
  environment.sessionVariables = {
    # if cursor no existo
    WLR_NO_HARDWARE_CURSORS = "1";
    # tell discord and such (electron apps) to use wayland
    NIXOS_OZONE_WL = "1";
    NH_FLAKE = "/etc/nixos/";
    NIXPKGS_ALLOW_INSECURE = "1";
    HSA_OVERRIDE_GFX_VERSION = "11.0.0";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
    # GDK_BACKEND = "x11"; # NEVER USE THIS WITH HYPRLAND
    LIBCLANG_PATH = "/home/saltcal/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-18.1.2_20240912/esp-clang/lib";
    # JAVA_HOME = "${pkgs.temurin-bin-24}";
    PATH = "/home/saltcal/Code/Personal/rust/projects/vanilla/dice/target/release:/home/saltcal/Code/Personal/rust/projects/vanilla/weather/target/release:/home/saltcal/.cargo/bin:/home/saltcal/Code/Personal/rust/projects/vanilla/prostrate_man/target/release:/home/saltcal/.rustup/toolchains/esp/xtensa-esp-elf/esp-14.2.0_20240906/xtensa-esp-elf/bin:$JAVA_HOME/bin:$PATH";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    ROCKET_CODEGEN_DEBUG = "1";
  };

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  services.pulseaudio = {
    enable = false;
    #   support32Bit = true;
  };

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      extraConfig.bluetoothEnhancements = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        };
      };
    };
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # BREAKS EVERYTHING
  # services.udev.extraRules = ''
  #   SUBSYSTEM == "usb",
  #   DRIVERS=="usb", ATTRS
  #   { idVendor }=="32ac", ATTRS{idProduct}=="0012", ATTR{power/wakeup}="disabled", ATTR{driver/1-1.1.1.4/power/wakeup}="disabled"
  #   SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0014", ATTR{power/wakeup}="disabled", ATTR{driver/1-1.1.1.4/power/wakeup}="disabled"
  # '';
  services.power-profiles-daemon.enable = true;

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove
    # nerdfonts
    # # (nerdfonts.override { fonts = [
    # #     "JetBrainsMono"
    # #   ];
    # # })
    # # JetBrainsMono
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
  boot.kernelPackages = pkgs.linuxPackages_latest;
}




