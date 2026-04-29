# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  inputs,
  username,
  ...
}:
{
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

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
  users.users.${username} = {
    isNormalUser = true;
    description = "Sal Cali";
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "dialout"
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
      lfs.enable = true;
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

    promptInit = ''
      eval "$(zoxide init --cmd cd zsh)"
    ''; # eval "$(zellij setup --generate-auto-start zsh)"

    shellAliases = {
      kys = ''echo "u too"; systemctl poweroff'';
      brb = ''echo "buh-bye!"; systemctl reboot'';
      eep = ''echo "zzz..."; systemctl sleep'';
      update = "cd /etc/nixos/ && sudo nix flake update";
      ls = "lsd -A";
      py = "python";
    };

    ohMyZsh = {
      enable = true;
      plugins = [
        "git" # "nix-shell"
      ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfreePredicate = nixpkgs-: true;
  environment.systemPackages = [
    pkgs.man-pages
    pkgs.nh
    inputs.uncpkgs.microsoft-edge
    inputs.zen-browser.packages.x86_64-linux.twilight
    pkgs.firefox
    pkgs.ripgrep
    pkgs.fd

    pkgs.zip
    pkgs.unzip
    pkgs.jq

    pkgs.zoxide
    pkgs.fzf
    pkgs.lsd
    pkgs.yazi
    pkgs.tmux

    pkgs.gitFull
    pkgs.gh

    pkgs.bat
    pkgs.eza

    pkgs.lolcat

    pkgs.nixd
    pkgs.nil
    pkgs.alejandra
  ];
  programs.nix-ld.enable = true;

  programs.direnv = {
    enable = true;
    settings = {
      hide_env_diff = true;
    };
  };

  # TODO fix
  environment.sessionVariables = {
    NH_OS_FLAKE = "/etc/nixos/";
    # NH_HOME_FLAKE = "/home/${username}/.config/home-manager";
    DEVSHELL_PATH = "/home/${username}/Code/devshells";
  };
}
