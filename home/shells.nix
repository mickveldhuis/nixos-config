{ config, pkgs, ... }:
let 
  aliases = {   
    ls = "eza --color=always";
    weather = "curl v2.wttr.in";
  };
in
{
  home.packages = with pkgs; [
    zsh
    oh-my-zsh
  ];

  # bash configuration
  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };

  # zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = aliases;
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "af-magic";
    };
  };

}
