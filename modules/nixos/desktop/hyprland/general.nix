{
  username,
  lua,
  activeTheme,
  ...
}:

{
  home-manager.users.${username} = { ... }: {
    wayland.windowManager.hyprland.settings.config.general = {
      # gaps_in = 5;
      # gaps_out = 20;

      # border_size = 2;

      # col = {
      #   active_border = {
      #     colors = [
      #       "rgba(33ccffee)"
      #       "rgba(00ff99ee)"
      #     ];
      #     angle = 45;
      #   };
      #   inactive_border = "rgba(595959aa)";
      # };

      # resize_on_border = true;

      # # Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
      # allow_tearing = false;

      # layout = "dwindle";

      gaps_in = 2;
      gaps_out = 4;

      border_size = 4;

      # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
      col.active_border = lua "0xff${builtins.substring 1 6 activeTheme.base0E}";
      col.inactive_border = lua "0x00${builtins.substring 1 6 activeTheme.base03}";

      # Set to true enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = true;

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false;

      layout = "dwindle";

      snap.enabled = false;
    };
  };
}
