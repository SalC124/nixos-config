{ ... }:
{
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      enable = true;
      efiSupport = true;
      useOSProber = true;
      extraEntries = ''
        menuentry "Reboot to Firmware Setup" {
          fwsetup
        }
      '';
      configurationLimit = 36;
      # theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze";
    };
    timeout = null;
  };
}
