{ activeTheme
, pkgs
, username
, lib
, ...
}:

let
  isDark = lib.elem activeTheme.name [
    "catppuccin-mocha"
    "nord"
    "gruvbox-dark"
    "catppuccin-frappe"
  ];

  cursors = {
    "catppuccin-mocha" = "Catppuccin Mocha Mauve";
    "catppuccin-frappe" = "Catppuccin Frappé Dark";
    "gruvbox-dark" = "Capitaine Cursors (Gruvbox)";
  };

  cursor-theme = cursors."${activeTheme.name}" or "Bibata-Modern-Ice";
in
{
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  home-manager.users.${username} = {
    home.packages = [
      pkgs.adw-gtk3
      pkgs.adwaita-qt
      pkgs.adwaita-qt6
    ];

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        cursorTheme = cursor-theme;
        color-scheme = if isDark then "prefer-dark" else "prefer-light";
        cursor-size = 24; # Matches your HYPRCURSOR_SIZE
        gtk-theme = "adw-gtk3";
      };
    };

    gtk = {
      enable = true;
      gtk2.force = true;

      theme = {
        name = "adw-gtk3";
        package = pkgs.adw-gtk3;
      };

      cursorTheme = {
        name = cursor-theme;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = if isDark then 1 else 0;
      };

      gtk4 = {
        theme = null;
        extraConfig = {
          gtk-application-prefer-dark-theme = if isDark then 1 else 0;
        };
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
  };
}
