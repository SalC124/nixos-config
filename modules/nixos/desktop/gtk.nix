{
  activeTheme,
  pkgs,
  username,
  ...
}:

let
  # Generate the CSS using your existing activeTheme variables
  # These names (accent_bg_color, etc.) are the standard Libadwaita variables
  gtkCss = ''
    @define-color accent_color ${activeTheme.base0E};
    @define-color accent_bg_color ${activeTheme.base0E};
    @define-color window_bg_color ${activeTheme.base00};
    @define-color window_fg_color ${activeTheme.base05};
    @define-color view_bg_color ${activeTheme.base01};
    @define-color view_fg_color ${activeTheme.base05};
    @define-color headerbar_bg_color ${activeTheme.base01};
    @define-color headerbar_fg_color ${activeTheme.base05};
    @define-color card_bg_color ${activeTheme.base01};
    @define-color card_fg_color ${activeTheme.base05};
    @define-color popover_bg_color ${activeTheme.base01};
    @define-color popover_fg_color ${activeTheme.base05};
  '';

  cursors = {
    "catppuccin-mocha" = "Catppuccin Mocha Mauve";
    "catppuccin-frappe" = "Catppuccin Frappé Dark";
    "gruvbox-dark" = "Capitaine Cursors (Gruvbox)";
  };
in
{
  environment.sessionVariables = {
    GTK_THEME = "adw-gtk3";
  };

  home-manager.users.${username} = {
    # Install adw-gtk3 for the structural look
    home.packages = [ pkgs.adw-gtk3 ];

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        cursor-theme = cursors."${activeTheme.name}" or "Bibata-Modern-Ice";
        cursor-size = 24; # Match your HYPRCURSOR_SIZE
      };
    };
    # Set the GTK 3.0 theme
    gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3";
        package = pkgs.adw-gtk3;
      };
    };

    # Inject your theme variables into the system CSS configs
    # This is the "Unification" step
    xdg.configFile = {
      "gtk-3.0/gtk.css".text = gtkCss;
      "gtk-4.0/gtk.css".text = gtkCss;
      "gtk-4.0/gtk-dark.css".text = gtkCss;
    };
  };
}
