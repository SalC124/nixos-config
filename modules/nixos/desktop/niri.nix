{
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./common-wayland.nix
  ];

  programs.niri.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = { };

  home-manager.users.${username} = {
    programs.swaylock.enable = true;
    services.mako.enable = true;
    services.swayidle.enable = true;

    home.packages = [
      pkgs.swaybg
    ];
  };
}
