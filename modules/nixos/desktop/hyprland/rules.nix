{
  username,
  lua,
  ...
}:

{
  home-manager.users.${username} = { ... }: {
    wayland.windowManager.hyprland.settings = {
      window_rule = [
        {
          name = "apply-floating";
          match.class = "floating";
          float = true;
          center = true;
          size = (lua "{798, 504}");
        }
        # {
        #   name = "suppress-maximize-events";
        #   match.class = ".*";
        #   suppress_event = "maximize";
        # }
        {
          match.initial_class = "labreconlinux.exe";
          float = true;
        }
        {
          match.initial_class = "lrcoder.exe";
          float = true;
        }
      ];
      workspace_rule = [
        {
          workspace = "6";
          layout = "scrolling";
        }
        {
          workspace = "7";
          layout = "scrolling";
        }
      ];
    };
  };
}
