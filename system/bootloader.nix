{ config, pkgs, ... }:

{
  # Use Grub as the default bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      devices = [ "nodev" ];
    };
    systemd-boot.enable = false;
  };
}