{
  pkgs,
  username,
  ...
}:

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

  programs.corectrl = {
    enable = true;
    package = pkgs.corectrl;
  };
  users.users.${username}.extraGroups = [ "corectrl" ];

  hardware.graphics.enable32Bit = true; # For 32 bit applications

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
}
