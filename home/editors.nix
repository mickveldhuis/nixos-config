{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    neovim
    vscode
  ];

  programs.vscode = {
    enable = true;
  };
}
