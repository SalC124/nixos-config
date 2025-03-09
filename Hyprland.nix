{ config
, pkgs
, lib
, inputs
, ...
}:

{
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.displayManager.defaultSession = "hyprland";

  programs.hyprland = {
    enable = true;
    # # set the flake package
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # # make sure to also set the portal package, so that they are in sync
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    # # withUWSM = true;
    xwayland.enable = true;
  };

  # nix.settings = {
  #   substituters = ["https://hyprland.cachix.org"];
  #   trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  # };

  # programs.uwsm.enable = true;

  boot.extraModprobeConfig = ''
    options i915 mitigations=off
  '';

  environment.systemPackages = [
    pkgs.kitty
    pkgs.swaynotificationcenter
    pkgs.hyprpolkitagent
    pkgs.wofi
    pkgs.hyprlock
    pkgs.swww
    pkgs.waybar

    pkgs.zellij
    pkgs.nemo
    pkgs.nautilus
    # pkgs.kdePackages.dolphin
    pkgs.zip
    pkgs.unzip

    pkgs.hyprshot
    pkgs.jq
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
    pkgs.libnotify
    pkgs.hyprpicker
    pkgs.swaynotificationcenter
    pkgs.hyprlock
    # pkgs.hypridle # probably wont end up using it
    pkgs.hyprpaper
    # pkgs.pavucontrol
    pkgs.pamixer
    pkgs.starship
    pkgs.swappy
    pkgs.playerctl
    pkgs.brightnessctl
    pkgs.pulsemixer
    pkgs.catppuccin-cursors.frappeDark
    pkgs.nwg-look
    pkgs.dconf-editor
    pkgs.banana-cursor
  ];
}
