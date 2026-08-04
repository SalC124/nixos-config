{
  pkgs,
  username,
  ...
}:

# lib.mkIf (config.specialisation != School )
{
  environment.systemPackages = [

    # inputs.nixpkgs-unstable.godot
    # (pkgs.callPackage ../../../pkgs-unstable/godot4_6/package.nix { })
    pkgs.pixelorama
    # pkgs.looking-glass-client
    pkgs.obs-studio
    pkgs.gnome-sudoku
    pkgs.protonup-ng
    pkgs.r2modman
    pkgs.dolphin-emu
    pkgs.lutris

    # pkgs.modrinth-app
    pkgs.ferium
    pkgs.prismlauncher
    pkgs.javaPackages.compiler.temurin-bin.jre-25

    # pkgs.retroarch-full
    # pkgs.retroarch-assets
    pkgs.mangohud
    pkgs.chiaki-ng

    pkgs.lmms
    pkgs.surge-XT
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
