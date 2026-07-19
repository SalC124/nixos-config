{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
  environment.sessionVariables = {
    # tell discord and such (electron apps) to use wayland
    NIXOS_OZONE_WL = "1";
  };

}
