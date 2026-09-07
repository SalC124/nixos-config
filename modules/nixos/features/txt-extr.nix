{
  pkgs,
  username,
  ...
}:
let
  txt-extr = pkgs.writeShellApplication {
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
  _module.args = { inherit txt-extr; };
  home-manager.users.${username}.home.packages = [ txt-extr ];
}
