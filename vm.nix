{ config, pkgs, lib, ... }:

with lib.gvariant;
let
  # Change this to your username.
  user = "saltcal";
  # Change this to match your system's CPU.
  platform = "amd";
  # Change this to specify the IOMMU ids you wrote down earlier.
  vfioIds = [ "1002:7480" ];
in

{
  boot = {
    kernelModules = [ "kvm-${platform}" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
    kernelParams = [ "${platform}_iommu=on" "${platform}_iommu=pt" "kvm.ignore_msrs=1" ];
    extraModprobeConfig = ''
      softdep drm pre: vfio-pci 
      options vfio-pci ids=${builtins.concatStringsSep "," vfioIds}
    '';
  };
  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];
  # Enable dconf (System Management Tool)
  programs.dconf.enable = true;

  # Add user to libvirtd group
  users.users.saltcal.extraGroups = [ "libvirtd" ];

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    adwaita-icon-theme
    # virtiofsd
    pciutils
  ];

  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  # programs.dconf = {
  #   profiles.user.databases = [
  #     {
  #       lockAll = false;
  #       settings = {
  #         "org/virt-manager/virt-manager" = {
  #           manager-window-height = mkInt32 300;
  #           manager-window-width = mkInt32 600;
  #           xmleditor-enabled = true;
  #         };

  #         "org/virt-manager/virt-manager/connections" = {
  #           autoconnect = [ "qemu:///system" ];
  #           uris = [ "qemu:///system" ];
  #         };

  #         # "virt-manager/conns/qemu:system" = {
  #         #   window-size = mkTuple [ 800 600 ];
  #         # };

  #         "org/virt-manager/virt-manager/console" = {
  #           autoconnect = true;
  #           resize-guest = mkInt32 1;
  #         };

  #         "org/virt-manager/virt-manager/details" = {
  #           show-toolbar = true;
  #         };

  #         "org/virt-manager/virt-manager/new-vm" = {
  #           graphics-type = "system";
  #         };

  #         "org/virt-manager/virt-manager/stats" = {
  #           enable-disk-poll = true;
  #           enable-memory-poll = true;
  #           enable-net-poll = true;
  #         };

  #         "org/virt-manager/virt-manager/vmlist-fields" = {
  #           disk-usage = true;
  #           network-traffic = true;
  #         };

  #         "org/virt-manager/virt-manager/paths" = {
  #           media-default = "/home/saltcal/ISOs";
  #         };

  #         # windows-11
  #         "org/virt-manager/virt-manager/vms/0822fe1e92d44bad8537766c9393cdda" = {
  #           autoconnect = mkInt32 1;
  #           resize-guest = mkInt32 1;
  #           scaling = mkInt32 0;
  #           # vm-window-size = mkTuple [ 1920 1200 ];
  #         };
  #         # sali-linux:[offsec]
  #         "org/virt-manager/virt-manager/vms/d6f2dd308119464494a33d1bb5f2268a" = {
  #           autoconnect = mkInt32 1;
  #           resize-guest = mkInt32 1;
  #           scaling = mkInt32 0;
  #           # vm-window-size = mkTuple [ 1920 1200 ];
  #         };
  #       };
  #     }
  #   ];
  # };
}
