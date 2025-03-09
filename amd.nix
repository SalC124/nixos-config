{ lib, config, pkgs, ... }:

{
  # Enable amd things
  # boot.initrd.kernelModules = [ "amdgpu" ];
  
  # Enable opencl
  hardware.amdgpu.opencl.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };
  
  # For Southern Islands (SI i.e. GCN 1) cards
  boot.kernelParams = [
    "radeon.si_support=0"
    "amdgpu.si_support=1"
    "video=DP-1:2560x1600@165"  # fix displays
    "video=DP-2:2560x1440@144"  # fix displays
  ];
}
