{
  username,
  ...
}:

{
  home-manager.users.${username} = { ... }: {
    wayland.windowManager.hyprland.settings = {
      config.input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;

        sensitivity = 0.75; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
          natural_scroll = true;
          tap_and_drag = false;
          # clickfinger_behavior = true
          disable_while_typing = false;
          middle_button_emulation = true;
        };
      };
    };
  };
}
