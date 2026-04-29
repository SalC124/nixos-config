{ config, pkgs, lib, ... }:

{
  config = lib.mkMerge [
    # Unconditional: satisfy the qemu-libvirtd assertion
    {
      users.groups.qemu-libvirtd = { };

      users.users.qemu-libvirtd = {
        isSystemUser = true;
        group = "qemu-libvirtd";
      };
    }

    # Conditional: your VFIO/libvirt setup
    (lib.mkIf config.vfio.enable {
      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [ pkgs.OVMFFull.fd ];
          };
        };
      };

      users.users.saltcal.extraGroups = [ "libvirtd" "kvm" "qemu-libvirtd" ];
      programs.virt-manager.enable = true;

      boot.extraModulePackages = [ config.boot.kernelPackages.kvmfr ];
      boot.kernelModules = [ "kvmfr" ];
      boot.extraModprobeConfig = ''
        options kvmfr static_size_mb=64
        options kvm_amd nested=1
      '';

      systemd.tmpfiles.rules = [
        "f /dev/kvmfr0 0660 saltcal kvm -"
        "d /home/saltcal/VMShared 0755 saltcal users -"
      ];

      system.activationScripts.virtioWinLink = ''
        mkdir -p /home/saltcal/VMShared
        ln -sfn ${pkgs.virtio-win} /home/saltcal/VMShared/virtio-win-drivers
        chown -h saltcal:users /home/saltcal/VMShared/virtio-win-drivers
      '';

      environment.systemPackages = with pkgs; [
        looking-glass-client
        virt-manager
        virtio-win
        spice-gtk
        virtiofsd
      ];

      environment.variables.VIRTIO_WIN_DIR = "${pkgs.virtio-win}";

      boot.kernelParams = [
        "default_hugepagesz=1G"
        "hugepagesz=1G"
        "hugepages=16"
      ];

      hardware.opengl.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;
    })
  ];
}
