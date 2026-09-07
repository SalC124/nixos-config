{
  activeTheme,
  pkgs,
  username,
  inputs,
  ...
}:

let
  hyprpaper = pkgs.hyprpaper;
in
{
  _module.args = { inherit hyprpaper; };
  home-manager.users.${username} =
    { ... }:
    {
      home.packages = [ hyprpaper ];
      home.file.".config/hypr/hyprpaper.conf" = {
        force = true;
        text = ''
          wallpaper {
              monitor =
              path = ${activeTheme.wallpaper}
              fit_mode = contain
          }
          splash = false
        '';
      };
      # home.activation.reloadHyprpaper = config.lib.dag.entryAfter [ "linkGeneration" ] ''
      #   $DRY_RUN_CMD ${pkgs.procps}/bin/pkill hyprpaper || true
      #   $DRY_RUN_CMD ${pkgs.hyprland}/bin/hyprctl dispatch exec hyprpaper
      # '';
    };
}
