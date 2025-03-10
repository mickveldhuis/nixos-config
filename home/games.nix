{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    itch
  ];
   
  programs.steam.enable = true;
}
