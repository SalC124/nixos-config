{
  activeTheme,
  username,
  pkgs,
  lib,
  ...
}:
let
  waybar = pkgs.waybar;
in
{
  _module.args = { inherit waybar; };
  home-manager.users.${username} =
    { ... }:
    {
      home.file.".config/waybar/config.jsonc" = {
        force = true;
        text = ''
          {
            "layer": "top",
            "position": "top",
            "spacing": 0,
            "height": 34,
            "modules-left": [
              // "custom/logo",
              "clock",
              "hyprland/workspaces"
            ],
            "modules-center": [
              "hyprland/window"
            ],
            "modules-right": [
              "tray",
              "memory",
              "network",
              "wireplumber",
              "battery",
              "custom/notifications",
              "custom/power"
            ],
            "wlr/taskbar": {
              "format": "{icon}",
              "on-click": "activate",
              "on-click-right": "fullscreen",
              "icon-activeTheme": "WhiteSur",
              "icon-size": 25,
              "tooltip-format": "{title}"
            },
            "hyprland/workspaces": {
              "on-click": "activate",
              "format": "{icon}",
              "format-icons": {
                "default": "",
                "1": "1",
                "2": "2",
                "3": "3",
                "4": "4",
                "5": "5",
                "6": "6",
                "7": "7",
                "8": "8",
                "9": "9",
                "10": "0",
                "active": "󱓻",
                "urgent": "󱓻"
              },
              "persistent_workspaces": {
                "1": [],
                "2": [],
                "3": [],
                "4": []
              }
            },
            "memory": {
              "interval": 5,
              "format": "󰍛 {}%",
              "max-length": 10
            },
            "tray": {
              "spacing": 10
            },
            "clock": {
              "tooltip-format": "{calendar}",
              "format-alt": "  {:%a, %d %b %Y}",
              "format": "  {:%I:%M %p}"
            },
            "network": {
              "format-wifi": "{icon} {essid}",
              "format-icons": [
                "󰤯",
                "󰤟",
                "󰤢",
                "󰤥",
                "󰤨"
              ],
              "format-ethernet": "󰀂",
              // "format-alt": "󱛇",
              "format-disconnected": "󰖪",
              "tooltip-format-wifi": "{icon} {essid}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}",
              "tooltip-format-ethernet": "󰀂  {ifname}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}",
              "tooltip-format-disconnected": "Disconnected",
              "on-click-right": "nmcli device disconnect wlp5s0",
              "on-click": "kitty --class floating 'nmtui'",
              "interval": 5,
              "nospacing": 1
            },
            "wireplumber": {
              "format": "{volume}% {icon} ",
              "format-bluetooth": "󰂰",
              "nospacing": 0,
              "tooltip-format": "Volume : {volume}%",
              "format-muted": "󰝟",
              "format-icons": {
                "headphone": "",
                "default": [
                  "󰖀",
                  "󰕾",
                  ""
                ]
              },
              "on-click": "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
              "scroll-step": 1,
              "on-click-right": "kitty --class floating '${lib.getExe pkgs.pulsemixer}'"
            },
            "custom/notifications": {
              "format": "notifications",
              "tooltip": false,
              "on-click": "swaync-client -op"
            },
            "custom/logo": {
              "format": "  ",
              "tooltip": false,
              "on-click": "~/.config/rofi/launchers/misc/launcher.sh &"
            },
            "battery": {
              "format": "{icon} {capacity}%",
              "format-icons": {
                "charging": [
                  "󰢜",
                  "󰂆",
                  "󰂇",
                  "󰂈",
                  "󰢝",
                  "󰂉",
                  "󰢞",
                  "󰂊",
                  "󰂋",
                  "󰂅"
                ],
                "default": [
                  "󰁺",
                  "󰁻",
                  "󰁼",
                  "󰁽",
                  "󰁾",
                  "󰁿",
                  "󰂀",
                  "󰂁",
                  "󰂂",
                  "󰁹"
                ]
              },
              "format-full": "Charged ",
              "interval": 5,
              "states": {
                "warning": 25,
                "critical": 15
              },
              "tooltip": false
            },
            "custom/power": {
              "format": "󰤆 hibernate",
              "tooltip": false,
              "on-click": "systemctl hibernate"
            }
          }
        '';
      };
      home.file.".config/waybar/style.css" = {
        force = true;
        text = ''
          * {
            border: none;
            border-radius: 0;
            min-height: 0;
            font-family: JetBrainsMono Nerd Font;
            font-size: 20px;
          }

          /* -----------------------------------------------------
           * BAR
           * ----------------------------------------------------- */

          window#waybar {
            background-color: rgba(0, 0, 0, 0);
            transition-property: background-color;
            transition-duration: 0.5s;
            color: ${activeTheme.base05};
          }

          window#waybar.hidden {
            opacity: 0.5;
          }

          /* -----------------------------------------------------
           * WORKSPACES
           * ----------------------------------------------------- */

          #workspaces {
            background-color: transparent;
          }

          #workspaces button {
            all: initial;
            min-width: 0;
            box-shadow: inset 0 -3px transparent;
            padding: 6px 18px;
            margin: 6px 3px;
            border-radius: 4px;

            background-color: ${activeTheme.base01};
            color: ${activeTheme.base05};
          }

          #workspaces button.active {
            background-color: ${activeTheme.base0D};
            color: ${activeTheme.base00};
          }

          #workspaces button:hover {
            background-color: ${activeTheme.base0D};
            color: ${activeTheme.base00};
          }

          #workspaces button.urgent {
            background-color: ${activeTheme.base08};
            color: ${activeTheme.base00};
          }

          /* -----------------------------------------------------
           * MODULES (shared)
           * ----------------------------------------------------- */

          #memory,
          #custom-power,
          #custom-notifications,
          #battery,
          #backlight,
          #wireplumber,
          #network,
          #clock,
          #tray {
            border-radius: 4px;
            margin: 6px 3px;
            padding: 6px 12px;

            background-color: ${activeTheme.base01};
            color: ${activeTheme.base05};
          }

          /* -----------------------------------------------------
           * LOGO
           * ----------------------------------------------------- */

          #custom-logo {
            padding-right: 7px;
            padding-left: 7px;
            margin-left: 5px;
            font-size: 15px;
            border-radius: 8px 0px 0px 8px;
            color: ${activeTheme.base0D};
          }

          /* -----------------------------------------------------
           * MEMORY
           * ----------------------------------------------------- */

          #memory {
            background-color: ${activeTheme.base0C}; /* cyan = system info */
            color: ${activeTheme.base00};
          }

          /* -----------------------------------------------------
           * BATTERY
           * ----------------------------------------------------- */

          #battery {
            background-color: ${activeTheme.base0B}; /* green = OK */
            color: ${activeTheme.base00};
          }

          #battery.warning {
            background-color: ${activeTheme.base09}; /* orange = warning */
            color: ${activeTheme.base00};
          }

          #battery.critical,
          #battery.urgent {
            background-color: ${activeTheme.base08}; /* red = critical */
            color: ${activeTheme.base00};
          }

          #battery.charging {
            background-color: ${activeTheme.base0B};
            color: ${activeTheme.base00};
          }

          /* -----------------------------------------------------
           * BACKLIGHT
           * ----------------------------------------------------- */

          #backlight {
            background-color: ${activeTheme.base09}; /* orange = attention */
            color: ${activeTheme.base00};
          }

          /* -----------------------------------------------------
           * AUDIO
           * ----------------------------------------------------- */

          #wireplumber {
            background-color: ${activeTheme.base0A}; /* yellow = audio/attention */
            color: ${activeTheme.base00};
          }

          /* -----------------------------------------------------
           * NETWORK
           * ----------------------------------------------------- */

          #network {
            background-color: ${activeTheme.base0D}; /* blue = primary accent */
            color: ${activeTheme.base00};
            padding-right: 17px;
          }

          /* -----------------------------------------------------
           * CLOCK
           * ----------------------------------------------------- */

          #clock {
            font-family: JetBrainsMono Nerd Font;
            background-color: ${activeTheme.base0E}; /* purple = secondary accent */
            color: ${activeTheme.base00};
          }

          /* -----------------------------------------------------
           * POWER
           * ----------------------------------------------------- */

          #custom-power {
            background-color: ${activeTheme.base09};
            color: ${activeTheme.base00};
            margin-right: 12px;
          }

          /* -----------------------------------------------------
           * NOTIFICATIONS
           * ----------------------------------------------------- */

          #custom-notifications {
            background-color: ${activeTheme.base03}; /* muted foreground */
            color: ${activeTheme.base00};
          }

          /* -----------------------------------------------------
           * TOOLTIP
           * ----------------------------------------------------- */

          tooltip {
            border-radius: 8px;
            padding: 15px;
            background-color: ${activeTheme.base01};
            color: ${activeTheme.base05};
          }

          tooltip label {
            padding: 5px;
            background-color: ${activeTheme.base01};
            color: ${activeTheme.base05};
          }
        '';
      };
      # home.activation.reloadWaybar = config.lib.dag.entryAfter [ "linkGeneration" ] ''
      #   $DRY_RUN_CMD ${pkgs.procps}/bin/pkill waybar || true
      #   $DRY_RUN_CMD ${pkgs.hyprland}/bin/hyprctl dispatch exec waybar
      # '';
    };
}
