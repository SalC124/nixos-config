{
  config,
  pkgs,
  username,
  ...
}:

{
  # 1. Boot parameters to enable IOMMU and bind dGPU to vfio-pci
  boot.kernelParams = [
    "amd_iommu=on" # Change to "intel_iommu=on" for Intel CPUs
    "iommu=pt"
    "vfio-pci.ids=1002:7480,1002:ab30" # My RX 7700S and its audio controller
  ];

  # Load VFIO drivers early in initrd so host drivers (nvidia/amdgpu) don't grab the dGPU
  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  # 2. Configure Libvirtd, UEFI (OVMF), and SWTPM for Windows 11 requirements
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      # "The 'virtualisation.libvirtd.qemu.ovmf' submodule has been removed.
      # All OVMF images distributed with QEMU are now available by default."
      # vvv
      # ovmf = {
      #   enable = true;
      #   packages = [ pkgs.OVMFFull.fd ]; # Secure Boot + UEFI firmware
      # };
      swtpm.enable = true; # Software TPM 2.0 required by Windows 11
    };
  };

  # 3. Add user to virtualization groups
  users.users.${username}.extraGroups = [
    "libvirtd"
    "kvm"
  ];

  # 4. Useful virtualization tools
  environment.systemPackages = with pkgs; [
    virt-manager
    pciutils
    looking-glass-client
  ];
}
