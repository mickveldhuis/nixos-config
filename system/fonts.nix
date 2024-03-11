{ config, pkgs, ... }:

{
  fonts = { 
    fontDir.enable = true;
    
    packages = with pkgs; [
      fira-code
      fira-code-symbols
      fira-code-nerdfont

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    
    fontconfig = {
      defaultFonts = {
        monospace = [ "Fira Code" ];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
