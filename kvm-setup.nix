{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.vfio.enable {
    # Enable virtualization
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true; # TPM emulation for Windows 11
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
      };
    };

    # Add your user to libvirtd group
    users.users.saltcal.extraGroups = [ "libvirtd" "kvm" ];

    # Enable virt-manager for GUI VM management
    programs.virt-manager.enable = true;

    # Looking Glass setup
    systemd.tmpfiles.rules = [
      # Create shared memory file for Looking Glass (128MB for 4K, adjust if needed)
      "f /dev/shm/looking-glass 0660 saltcal kvm -"
      # Create shared folder for VM
      "d /home/saltcal/VMShared 0755 saltcal users -"
    ];

    # Symlink virtio-win drivers into shared folder for easy Windows access
    system.activationScripts.virtioWinLink = ''
      mkdir -p /home/saltcal/VMShared
      ln -sfn ${pkgs.virtio-win} /home/saltcal/VMShared/virtio-win-drivers
      chown -h saltcal:users /home/saltcal/VMShared/virtio-win-drivers
    '';

    # Install Looking Glass client and VM tools
    environment.systemPackages = with pkgs; [
      looking-glass-client
      virt-manager
      virtio-win # Windows virtio drivers
      spice-gtk # For SPICE tools
    ];

    # Make virtio-win drivers easily accessible
    environment.variables = {
      VIRTIO_WIN_DIR = "${pkgs.virtio-win}";
    };

    # Optimize for VM performance
    boot.kernelParams = [
      "hugepagesz=1G"
      "hugepages=16" # Reserve 16GB of hugepages for better VM performance
    ];

    # Enable nested virtualization (optional, useful for testing)
    boot.extraModprobeConfig = ''
      options kvm_amd nested=1
    '';
  };
}
