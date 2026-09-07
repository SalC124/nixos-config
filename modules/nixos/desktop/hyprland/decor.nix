{
  username,
  ...
}:

{
  home-manager.users.${username} = { ... }: {
    wayland.windowManager.hyprland.settings.config.decoration = {
      rounding = 8;

      active_opacity = 1.0; # 0.85
      inactive_opacity = 1.0; # 0.85

      shadow.enabled = false;

      blur = {
        enabled = true;
        size = 3;
        passes = 3; # 5
        new_optimizations = true;
        noise = 0.0;

        vibrancy = 0.1; # 0.1696
      };
    };
  };
}
