{
  activeTheme,
  pkgs,
  username,
  lib,
  ...
}:

let
  isDark = lib.elem activeTheme.name [
    "catppuccin-mocha"
    "nord"
    "gruvbox-dark"
    "catppuccin-frappe"
  ];

  # Generate the CSS using your existing activeTheme variables
  # These names (accent_bg_color, etc.) are the standard Libadwaita variables
  gtkCss = ''
    /* 1. Base Colors (The ones you already have) */
    @define-color accent_color ${activeTheme.base0E};
    @define-color accent_bg_color ${activeTheme.base0E};
    @define-color window_bg_color ${activeTheme.base00};
    @define-color window_fg_color ${activeTheme.base05};

    /* 2. The Sidebar & List View Fixes (The stuff you were missing) */
    @define-color view_bg_color ${activeTheme.base00};
    @define-color view_fg_color ${activeTheme.base05};
    @define-color sidebar_bg_color ${activeTheme.base01};
    @define-color sidebar_fg_color ${activeTheme.base05};
    @define-color secondary_sidebar_bg_color ${activeTheme.base01};
    @define-color secondary_sidebar_fg_color ${activeTheme.base05};

    /* 3. Cards and Dialogs */
    @define-color card_bg_color ${activeTheme.base01};
    @define-color card_fg_color ${activeTheme.base05};
    @define-color dialog_bg_color ${activeTheme.base00};
    @define-color dialog_fg_color ${activeTheme.base05};
    @define-color popover_bg_color ${activeTheme.base01};
    @define-color popover_fg_color ${activeTheme.base05};

    /* 4. Headerbars (Top Bars) */
    @define-color headerbar_bg_color ${activeTheme.base01};
    @define-color headerbar_fg_color ${activeTheme.base05};
    @define-color headerbar_border_color ${activeTheme.base01};
    @define-color headerbar_backdrop_color @window_bg_color;

    /* 5. Inputs and Selections */
    @define-color focus_border_color ${activeTheme.base0E};
    @define-color selection_bg_color ${activeTheme.base0E};
    @define-color selection_fg_color ${activeTheme.base00};

    /* 6. Hard-coding the sidebar node (The "Nuclear" fix for portals) */
    stacksidebar.sidebar list,
    .navigation-sidebar,
    .sidebar {
      background-color: ${activeTheme.base01};
    }
  '';

  cursors = {
    "catppuccin-mocha" = "Catppuccin Mocha Mauve";
    "catppuccin-frappe" = "Catppuccin Frappé Dark";
    "gruvbox-dark" = "Capitaine Cursors (Gruvbox)";
  };

  cursor-theme = cursors."${activeTheme.name}" or "Bibata-Modern-Ice";
in
{
  environment.sessionVariables = {
    # GTK_THEME = "adw-gtk3";
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  home-manager.users.${username} = {
    # Install adw-gtk3 for the structural look
    home.packages = [
      pkgs.adw-gtk3
      pkgs.adwaita-qt
      pkgs.adwaita-qt6
    ];

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        cursorTheme = cursor-theme;
        color-scheme = if isDark then "prefer-dark" else "prefer-light";
        cursor-size = 24; # Match your HYPRCURSOR_SIZE
        gtk-theme = "adw-gtk3";
      };
    };
    # Set the GTK 3.0 theme
    gtk = {
      enable = true;
      gtk2.force = true;
      theme = {
        name = "adw-gtk3";
        package = pkgs.adw-gtk3;
      };
      cursorTheme = {
        name = cursor-theme;
        package = pkgs.adwaita-qt6;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = if isDark then 1 else 0;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = if isDark then 1 else 0;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk3";
      style = {
        name = if isDark then "adwaita-dark" else "adwaita";
        package = pkgs.adwaita-qt6;
      };
    };

    # Inject your theme variables into the system CSS configs
    # This is the "Unification" step
    xdg = {
      configFile = {
        "gtk-3.0/gtk.css".text = gtkCss;
        "gtk-4.0/gtk.css".text = gtkCss;
        "gtk-4.0/gtk-dark.css".text = gtkCss;
      };
    };
  };
}
