{
  pkgs,
  username,
  ...
}:
{
  environment.systemPackages = [

    pkgs.pixelorama
    pkgs.obs-studio
    pkgs.gnome-sudoku
    pkgs.protonup-ng
    pkgs.r2modman

    pkgs.prismlauncher
    pkgs.javaPackages.compiler.temurin-bin.jre-25

    pkgs.mangohud

    pkgs.lmms
    pkgs.surge-xt
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
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
