{
  activeTheme,
  pkgs,
  username,
  ...
}:
{
  home-manager.users.${username} = {
    home.packages = [
      pkgs.kitty
    ];
    home.file.".config/kitty/kitty.conf" = {
      force = true;
      text = ''
        include style.conf

        confirm_os_window_close 0

        font_family CaskaydiaCove Nerd Font Mono
        bold_font        auto
        italic_font      auto
        bold_italic_font auto

        font_size 18

        background_opacity 0.0

        tab_bar_edge     top
        tab_bar_style    slant

        cursor_trail                    1
        cursor_trail_start_threshold    2
      '';
    };
    home.file.".config/kitty/style.conf" = {
      force = true;
      text = ''
        # vim:ft=kitty
        # Primary colors
        foreground              ${activeTheme.base04}
        background              ${activeTheme.base00}
        selection_foreground    ${activeTheme.base00}
        selection_background    ${activeTheme.base0E}

        # Cursor
        cursor                  ${activeTheme.base05}
        cursor_text_color       ${activeTheme.base00}

        # URL hover
        url_color               ${activeTheme.base0D}

        # Borders
        active_border_color     ${activeTheme.base0E}
        inactive_border_color   ${activeTheme.base03}
        bell_border_color       ${activeTheme.base0E}

        # Tabs
        active_tab_foreground   ${activeTheme.base00}
        active_tab_background   ${activeTheme.base0E}
        inactive_tab_foreground ${activeTheme.base04}
        inactive_tab_background #181825
        tab_bar_background      #11111B

        # Marks
        mark1_foreground ${activeTheme.base00}
        mark1_background ${activeTheme.base0E}
        mark2_foreground ${activeTheme.base00}
        mark2_background ${activeTheme.base04}
        mark3_foreground ${activeTheme.base00}
        mark3_background ${activeTheme.base0D}

        # Terminal colors — yellows replaced with light purples

        # black
        color0  ${activeTheme.base02}
        color8  ${activeTheme.base03}

        # red
        color1  ${activeTheme.base08}
        color9  ${activeTheme.base08}

        # green
        color2  ${activeTheme.base0B}
        color10 ${activeTheme.base0B}

        # "yellow" (now purple!)
        color3  ${activeTheme.base0A}
        color11 ${activeTheme.base0A}

        # blue
        color4  ${activeTheme.base0D}
        color12 ${activeTheme.base0D}

        # magenta
        color5  ${activeTheme.base0E}
        color13 ${activeTheme.base0E}

        # cyan
        color6  ${activeTheme.base0C}
        color14 ${activeTheme.base0C}

        # white
        color7  ${activeTheme.base0F}
        color15 ${activeTheme.base04}
      '';
    };
  };
}
