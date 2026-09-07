{
  username,
  lib,
  lua,
  bin,
  pkgs,

  kitty,
  fuzzel,
  txt-extr,

  ...
}:

{
  imports = [
    ../../features/kitty.nix
    ../../features/fuzzel.nix
    ../../features/txt-extr.nix
  ];

  home-manager.users.${username} = { ... }: {
    wayland.windowManager.hyprland.settings = {
      browser = {
        _var = "zen-twilight -P Personal";
      };
      schoolBrowser = {
        _var = "zen-twilight -p nouveau --new-tab https://salc124.github.io/";
      };

      bind = [
        {
          _args = [
            "SUPER + Q"
            (lua ''hl.dsp.exec_cmd("${bin kitty}")'')
          ];
        }
        {
          _args = [
            "SUPER + A"
            (lua ''hl.dsp.exec_cmd("${bin kitty}",{float=true,size={798,504}})'')
          ];
        }
        {
          _args = [
            "SUPER + C"
            (lua "hl.dsp.window.close()")
            { locked = true; }
          ];
        }
        {
          _args = [
            "SUPER + mouse:272"
            (lua "hl.dsp.window.drag()")
            { mouse = true; }
          ];
        }
        {
          _args = [
            "SUPER + mouse:273"
            (lua "hl.dsp.window.resize()")
            { mouse = true; }
          ];
        }
        {
          _args = [
            "SUPER + M"
            (lua ''hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")'')
          ];
        }
        {
          _args = [
            "SUPER + SPACE"
            (lua ''hl.dsp.exec_cmd("${bin fuzzel}")'')
          ];
        }
        {
          _args = [
            "SUPER + E"
            (lua ''hl.dsp.exec_cmd("${bin pkgs.nautilus}",{float=true,size={900,600}})'')
          ];
        }
        {
          _args = [
            "SUPER + B"
            (lua "hl.dsp.exec_cmd(browser)")
          ];
        }
        {
          _args = [
            "SUPER + Z"
            (lua "hl.dsp.exec_cmd(schoolBrowser)")
          ];
        }

        {
          _args = [
            "SUPER + F"
            (lua "hl.dsp.window.fullscreen({mode='fullscreen',action='toggle'})")
          ];
        }

        {
          _args = [
            "SUPER + SHIFT + T"
            (lua ''hl.dsp.exec_cmd("${bin txt-extr}")'')
          ];
        }

        {
          _args = [
            "XF86AudioRaiseVolume"
            (lua ''hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")'')
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioLowerVolume"
            (lua ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")'')
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioMute"
            (lua ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'')
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioMicMute"
            (lua ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")'')
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86MonBrightnessUp"
            (lua ''hl.dsp.exec_cmd("${bin pkgs.brightnessctl} -e4 -n2 set 5%+")'')
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (lua ''hl.dsp.exec_cmd("${bin pkgs.brightnessctl} -e4 -n2 set 5%-")'')
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioNext"
            (lua ''hl.dsp.exec_cmd("${bin pkgs.playerctl} next")'')
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPause"
            (lua ''hl.dsp.exec_cmd("${bin pkgs.playerctl} play-pause")'')
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPlay"
            (lua ''hl.dsp.exec_cmd("${bin pkgs.playerctl} play-pause")'')
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPrev"
            (lua ''hl.dsp.exec_cmd("${bin pkgs.playerctl} previous")'')
            { locked = true; }
          ];
        }

      ]
      # workspaces
      ++ lib.flatten (
        lib.zipListsWith (bind: workspace: [
          {
            _args = [
              "SUPER + ${toString bind}"
              (lua "hl.dsp.focus({workspace=${toString workspace}})")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + ${toString bind}"
              (lua "hl.dsp.window.move({workspace=${toString workspace}})")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + CTRL + ${toString bind}"
              (lua "hl.dsp.window.move({workspace=${toString workspace},follow=false})")
            ];
          }
        ]) ((lib.map (x: x + 1) (lib.genList (x: x) 9)) ++ [ 0 ]) (lib.genList (x: x + 1) 10)
      );
    };
  };
}
