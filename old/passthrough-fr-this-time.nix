# https://astrid.tech/2022/09/22/0/nixos-gpu-vfio/

{ lib, config, pkgs, ... }:

let
  # Radeon RX 7700S (Navi 33)
  gpuIDs = [
    "1002:7480" # Radeon RX 7700S GPU (Navi 33)
    "1002:ab30" # Radeon RX 7700S HDMI/DP Audio (Navi 31)
  ];
in
{
  options.vfio.enable = with lib;
    mkEnableOption "Configure the machine for VFIO GPU passthrough";

  config =
    let cfg = config.vfio;
    in {
      boot = {
        # Load VFIO modules BEFORE amdgpu to claim the RX 7700S first
        initrd.kernelModules = [
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"

          # Load amdgpu after VFIO so your integrated Radeon 780M still works
          "amdgpu"
        ];

        kernelParams = [
          # Enable IOMMU for AMD CPUs
          "amd_iommu=on"
          "iommu=pt" # Use passthrough mode for better performance
        ] ++ lib.optional cfg.enable
          # Isolate the RX 7700S when VFIO is enabled
          ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
      };

      # Enable OpenGL for your host (integrated Radeon 780M)
      hardware.opengl.enable = true;

      # Enable SPICE USB redirection for easy device hotplugging into VMs
      virtualisation.spiceUSBRedirection.enable = true;

      # Create a specialisation for booting with VFIO enabled
      specialisation."VFIO".configuration = {
        system.nixos.tags = [ "with-vfio" ];
        vfio.enable = true;
      };
    };
}
