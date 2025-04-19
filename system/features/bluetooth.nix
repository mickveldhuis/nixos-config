{ config, pkgs, ... }:

{
  # Enable support for Bluetooth devices
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}