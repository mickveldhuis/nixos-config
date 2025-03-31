{ config, pkgs, ... }:

{
  # Use Grub as the default bootloader for all hosts.
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
    # Want to use systemd-boot instead? Set the following to `true`.
    # TODO: add logic to enable GRUB of systemd-boot based on the host!
    systemd-boot.enable = false;
  };
}