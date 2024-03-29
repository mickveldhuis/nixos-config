# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      
      # Include system level configuration files
      ./system
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the LXQT Desktop Environment.
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.lxqt.enable = true;

  # Enable the Gnome Desktop Enviroment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable the DWM Window Manager & Fetch source repo from GitHub
  services.xserver.windowManager.dwm.enable = true;
  
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
    src = pkgs.fetchFromGitHub {
      owner = "mickveldhuis";
      repo = "dwm";
      rev = "f087225bc585c902163d5e4ffa58b83394b49d53";
      sha256 = "sha256-wrTVwKLXntAZAvGivvgXtMEXb+AXN0X6GsvoaA5v09c=";
    };
    patches = [
    (pkgs.fetchpatch {
      url = "https://dwm.suckless.org/patches/attachaside/dwm-attachaside-6.4.diff";
      hash = "sha256-590VHm9Usla+o16m1nZ/JWPSK0ixBsT/DGWBOji+89k=";
    })
  ];
  });
  
  # Start dwm status bar
  services.xserver.displayManager.sessionCommands = ''slstatus &'';
  
  # Set appropriate monitor resolution
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output Virtual-1 --mode 1920x1080
  '';
  
  # Enable compositing for dwm with picom
  services.picom = {
    enable = true;
    settings = {};
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
 
  # Setting ZSH to be the default shell
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
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
  system.stateVersion = "23.11";
  
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
