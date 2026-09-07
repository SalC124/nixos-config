{
  pkgs,
  lib,
  username,
  waybar,
  ...
}:

let
  lua = lib.generators.mkLuaInline;
  bin = pkg: lib.getExe pkg;
in
{
  _module.args = { inherit lua bin; };

  services.xserver.enable = false; # perchance dont need it
  services.displayManager.gdm.enable = false;

  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = true;
  };

  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [
    hyprpolkitagent
  ];

  services.logind.settings.Login.HandleLidSwitch = "ignore";
  services.logind.settings.Login.HandlePowerKey = "suspend";

  home-manager.users.${username} = { ... }: {
    home.packages = [
      pkgs.wl-clipboard
      pkgs.hyprshot

      waybar
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      systemd.enable = false;
      settings = {
        monitor = [
          {
            output = "eDP-2";
            mode = "2560x1600@165";
            position = "2560x0";
            scale = 1;
          }
          {
            output = "eDP-1";
            mode = "2560x1600@165";
            position = "2560x0";
            scale = 1;
          }
        ];
      };
    };
  };
  imports = [
    ./animations.nix
    ./binds.nix
    ./decor.nix
    ./general.nix
    ./gestures.nix
    ./rules.nix
    ./hooks.nix
    ./inputs.nix
    ./rules.nix
  ];
}
