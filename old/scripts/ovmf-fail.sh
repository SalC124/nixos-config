sudo install -d /var/lib/libvirt/qemu/nvram
sudo cp /run/libvirt/nix-ovmf/OVMF_VARS.fd /var/lib/libvirt/qemu/nvram/win11_VARS.fd
sudo chown root:root /var/lib/libvirt/qemu/nvram/win11_VARS.fd
