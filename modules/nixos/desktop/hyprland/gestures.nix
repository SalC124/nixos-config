{
  username,
  ...
}:

{
  # https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
  home-manager.users.${username} = { ... }: {
    wayland.windowManager.hyprland.settings.gesture = [
      {
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      }
      {
        fingers = 4;
        direction = "up";
        # mods = "SUPER";
        action = "special";
        workspace_name = "scratchpad";
        # disable_inhibit = true;
      }
    ];
  };
}
