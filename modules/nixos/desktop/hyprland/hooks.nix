{
  username,
  lua,
  bin,

  waybar,
  hyprpaper,
  ...
}:

{
  imports = [
    ../../features/waybar.nix
    ../../features/hyprpaper.nix
  ];

  home-manager.users.${username} = { ... }: {
    wayland.windowManager.hyprland.settings = {
      on = [
        {
          _args = [
            "hyprland.start"
            (lua ''
              function()
                hl.exec_cmd("${bin waybar}")
                hl.exec_cmd("${bin hyprpaper}")
              end
            '')
          ];
        }
        {
          _args = [
            "config.reloaded"
            (lua ''
              function()
                hl.exec_cmd("pkill $(basename ${bin waybar}); ${bin waybar}")
                hl.exec_cmd("pkill $(basename ${bin hyprpaper}); ${bin hyprpaper}")
              end
            '')
          ];
        }
      ];
    };
  };
}
