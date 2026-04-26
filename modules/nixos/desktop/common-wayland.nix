{
  lib,
  pkgs,
  username,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    wl-clipboard
    libnotify
  ];

  services.gnome.gnome-keyring.enable = true;

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      swww
      wofi
      grim
      slurp
    ];

    home.sessionVariables = {
      # if cursor no existo
      WLR_NO_HARDWARE_CURSORS = "1";
      # tell discord and such (electron apps) to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };
}
