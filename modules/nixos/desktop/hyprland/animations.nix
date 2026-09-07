{
  username,
  ...
}:

{
  home-manager.users.${username} = { ... }: {
    wayland.windowManager.hyprland.settings = {
      config.animations = {
        enabled = true;
      };
      animation = [ ];
    };
  };
}
