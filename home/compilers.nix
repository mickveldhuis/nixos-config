{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc
    python3
    julia
  ];
}
