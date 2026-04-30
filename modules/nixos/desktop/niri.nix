{
  pkgs,
  inputs,
  username,
  ...
}:
{
  imports = [
    ./common-wayland.nix
    ../features/kitty.nix
    ../features/waybar.nix
    ../features/fuzzel.nix
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
