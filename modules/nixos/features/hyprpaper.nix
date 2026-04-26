{
  activeTheme,
  pkgs,
  username,
  ...
}:
{
  home-manager.users.${username} =
    { config, ... }:
    {
      home.packages = [ pkgs.hyprpaper ];
      home.file.".config/hypr/hyprpaper.conf" = {
        force = true;
        text = ''
          preload = ${activeTheme.wallpaper}
          wallpaper = , ${activeTheme.wallpaper}
        '';
      };
      # home.activation.reloadHyprpaper = config.lib.dag.entryAfter [ "linkGeneration" ] ''
      #   $DRY_RUN_CMD ${pkgs.procps}/bin/pkill hyprpaper || true
      #   $DRY_RUN_CMD ${pkgs.hyprland}/bin/hyprctl dispatch exec hyprpaper
      # '';
    };
}
