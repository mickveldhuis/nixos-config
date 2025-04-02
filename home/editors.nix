{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnuradio
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
 
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = true;
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      yzhang.markdown-all-in-one
      bbenoist.nix
      ms-python.python
    ];
    userSettings = {
      "window.titleBarStyle" = "custom";
      "editor.fontFamily" = "Fira Code";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 15;
    };
  };
}
