{ lib, config, pkgs, ... }:
{
  options.vfio.enable = with lib;
    mkEnableOption "Configure the machine for VFIO GPU passthrough";

  config = {
    # Enable OpenGL for your host (integrated Radeon 780M)
    hardware.opengl.enable = true;

    # Enable SPICE USB redirection
    virtualisation.spiceUSBRedirection.enable = true;

    # Create a specialisation for booting with VFIO enabled
    specialisation."VFIO".configuration = {
      system.nixos.tags = [ "with-vfio" ];
      vfio.enable = true;
    };
  };
}
