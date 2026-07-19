{
  pkgs,
  username,
  ...
}:

{
  xdg.portal.wlr.enable = true;
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  environment.systemPackages = with pkgs; [
    libnotify
  ];
  environment.sessionVariables = {
    # if cursor no existo
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  services.gnome.gnome-keyring.enable = true;

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      swww
      wofi
      grim
      slurp
    ];
  };
}
