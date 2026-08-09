{
  pkgs,
  username,
  ...
}:

{
  services.displayManager.gdm.enable = true;
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
      awww
      wofi
      grim
      slurp
    ];
  };
}
