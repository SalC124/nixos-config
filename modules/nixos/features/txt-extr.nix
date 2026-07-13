{
  pkgs,
  username,
  ...
}:
let
  extractToClipboard = pkgs.writeShellApplication {
    name = "txt-extr";
    runtimeInputs = [
      pkgs.hyprshot
      pkgs.tesseract
      pkgs.wl-clipboard
    ];
    text = ''
      hyprshot -m region --raw | tesseract stdin stdout | wl-copy
    '';
  };
in
{
  home-manager.users.${username}.home.packages = [ extractToClipboard ];
}