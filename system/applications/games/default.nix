{ config, pkgs, ... }:

{
  # System-wide applications
  programs.steam.enable = true;

  # Drivers for using xbox wireless controllers via Bluetooth
  hardware.xpadneo.enable = true;
}
