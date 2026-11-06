{
  username,
  lua,
  bin,

  waybar,
  hyprpaper,
  pkgs,
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
                hl.exec_cmd("${bin pkgs.swaynotificationcenter}")
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
