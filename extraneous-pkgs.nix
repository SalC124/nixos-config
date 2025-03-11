{ lib
, config
, pkgs
, ...
}:

# lib.mkIf (config.specialisation != School )
{
  environment.systemPackages = [

    pkgs.godot_4
    pkgs.pixelorama
    # pkgs.looking-glass-client
    pkgs.obs-studio
    pkgs.gnome-sudoku
    pkgs.protonup
    pkgs.r2modman
    pkgs.dolphin-emu
    pkgs.lutris

    pkgs.modrinth-app
    pkgs.ferium
    pkgs.prismlauncher
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/saltcal/.steam/root/compatibilitytools.d";
  };

  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
    gamemode.enable = true;
  };
  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
  };

}
