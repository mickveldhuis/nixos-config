# --------------------------------------------------------------------- #
#                       LAPTOP NIXOS CONFIGURATION                      #
# --------------------------------------------------------------------- #
# Edit this configuration file to define what should be installed on    #
# your system.  Help is available in the configuration.nix(5) man page  #
# and in the NixOS manual (accessible by running ‘nixos-help’).         #
# --------------------------------------------------------------------- #

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      
      # Include system level configuration files
      ../../system
      ../../system/environments/gnome
    ];

  networking.hostName = "nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;
 
  # Setting ZSH to be the default shell
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mick = {
    isNormalUser = true;
    description = "mick";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # left empty, using home-manager instead..!
    ];
  };

  # Enable automatic login for the user.
  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = "mick";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search PACKAGE_NAME 
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    eza
    slstatus
    dmenu
  ];
  
  nixpkgs.overlays = [
    (self: super: {
      slstatus = super.slstatus.overrideAttrs (oldAttrs: rec {
        src = pkgs.fetchFromGitHub {
          owner = "mickveldhuis";
          repo = "slstatus";
          rev = "9c0617bfda0b1ee301e945b47c14cee59f9e1519";
          sha256 = "sha256-+Ljm6+2TDo2kV/VOhVLU+Qo7NNdAzILrbcqNVT90qS8=";
        };
      });
    })
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11";
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.allowed-users = [ "mick" ];

  # Enable weekly garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Optimise storage
  nix.settings.auto-optimise-store = true;
}
