{ lib, config, pkgs, ... }:

{
  # Enable amd things
  # boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    # amdvlk # deprecated. radv enabled by default
  ];
  environment.systemPackages = with pkgs; [
    clinfo
    lact
  ];
  environment.sessionVariables = {
    # MESA_GL_VERSION_OVERRIDE = "3.0";
  };

  programs.corectrl.enable = true;

  hardware.graphics.enable32Bit = true; # For 32 bit applications

  # For 32 bit applications 
  hardware.graphics.extraPackages32 = with pkgs; [
    # driversi686Linux.amdvlk # depr-d.
  ];

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  # # Enable opencl
  # hardware.amdgpu.opencl.enable = true;
  #
  # hardware.graphics = {
  #   enable = true;
  #   enable32Bit = true;
  #   extraPackages = with pkgs; [
  #     rocmPackages.clr.icd
  #     amdvlk
  #   ];
  #   extraPackages32 = with pkgs; [
  #     driversi686Linux.amdvlk
  #   ];
  # };

  # For Southern Islands (SI i.e. GCN 1) cards
  boot.kernelParams = [
    "radeon.si_support=0"
    "amdgpu.si_support=1"
    "video=eDP-2:2560x1600@165" # fix displays
    "video=DP-1:2560x1440@144" # fix displays
  ];
}
