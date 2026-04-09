{
  lib,
  stdenv,
  fetchzip,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  copyDesktopItems,
  makeDesktopItem,
  alsa-lib,
  dbus,
  fontconfig,
  freetype,
  libGL,
  libX11,
  libXcursor,
  libXext,
  libXfixes,
  libXi,
  libXinerama,
  libXrandr,
  libXrender,
  libpulseaudio,
  libxkbcommon,
  udev,
  vulkan-loader,
  wayland,
  zlib,
}:

stdenv.mkDerivation rec {
  pname = "godot";
  version = "4.6-stable";

  src = fetchzip {
    url = "https://github.com/godotengine/godot-builds/releases/download/4.6-stable/Godot_v4.6-stable_linux.x86_64.zip";
    hash = "sha256-/5IqQFzDcw4rUsngBjMSTSIjjN46aS4wZpe7c/pL2Uc=";
    stripRoot = false;
  };

  icon = fetchurl {
    url = "https://raw.githubusercontent.com/godotengine/godot/master/icon.svg";
    hash = "sha256-FEOul0hCuBdl1bUOanKeu/Qeui6eUVqwkZ8upci49HU=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    copyDesktopItems
  ];

  buildInputs = [
    alsa-lib
    dbus
    fontconfig
    freetype
    libGL
    libX11
    libXcursor
    libXext
    libXfixes
    libXi
    libXinerama
    libXrandr
    libXrender
    libpulseaudio
    libxkbcommon
    udev
    vulkan-loader
    wayland
    zlib
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 Godot_v${version}_linux.x86_64 $out/bin/godot

    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp ${icon} $out/share/icons/hicolor/scalable/apps/godot.svg

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "godot";
      desktopName = "Godot Engine";
      comment = "Multi-platform 2D and 3D game engine";
      exec = "godot %F";
      icon = "godot";
      terminal = false;
      type = "Application";
      categories = [
        "Development"
        "IDE"
      ];
      mimeTypes = [
        "application/x-godot-project"
      ];
      startupNotify = true;
    })
  ];

  fixupPhase = ''
    runHook preFixup

    wrapProgram $out/bin/godot \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs} \
      --set ALSA_PLUGIN_DIR ${alsa-lib}/lib/alsa-lib

    runHook postFixup
  '';

  meta = with lib; {
    description = "Free and Open Source 2D and 3D game engine";
    homepage = "https://godotengine.org";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ ];
    mainProgram = "godot";
  };
}
