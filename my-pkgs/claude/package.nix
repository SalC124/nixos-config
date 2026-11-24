{
  lib,
  symlinkJoin,
  makeDesktopItem,
  writeShellScriptBin,
  chromium,
}:

let
  claudeBin = writeShellScriptBin "claude-ai" ''
    exec ${chromium}/bin/chromium \
      --app=https://claude.ai \
      --class=ClaudeAI \
      "$@"
  '';

  desktopItem = makeDesktopItem {
    name = "claude-ai";
    desktopName = "Claude";
    exec = "claude-ai";
    icon = "chromium";
    categories = [
      "Network"
      "Utility"
    ];
    startupWMClass = "ClaudeAI";
  };
in
symlinkJoin {
  name = "claude-ai";
  paths = [
    claudeBin
    desktopItem
  ];

  meta = {
    description = "Standalone Chromium web app for Claude";
    mainProgram = "claude-ai";
    platforms = lib.platforms.linux;
  };
}
