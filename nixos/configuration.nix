# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Auto update
  system.autoUpgrade.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # XDG Portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    wlr.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.am = {
    isNormalUser = true;
    description = "Amogh Shakya";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    shell = pkgs.zsh; # Default Shell
    packages = with pkgs; [
      google-chrome
      gh # GitHub CLI
      starship # Prompt
      stow # GNU stow for dotfiles
      obsidian # Note Taking
      fzf
      zoxide

      # fun stuff
      cbonsai
      cmatrix
      
    ];
  };

  # Display Manager
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Experimental Settings 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    vscode
    spotify
    spicetify-cli
    neovim
    git
    htop
    whitesur-cursors
    killall

    # dev tools
    gcc
    clang
    jdk
    python3
    rustup

    # terminal emulator
    kitty

    # notifications
    dunst
    libnotify

    # launcher
    rofi-wayland

    # waybar
    waybar

    # wallpaper
    swww

    # clipboard
    wl-clipboard

    # screenshots
    grim
    slurp

    # gtk 
    nwg-look
    hyprcursor # cursors

    # file manager 
    dolphin
    yazi
  ];

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    jetbrains-mono
    
    # Nerd Fonts
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];


  programs.zsh.enable = true;
  programs.firefox.enable = true;
  programs.dconf.enable = true;

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  systemd.services.hyprland = {
    enable = true;
    script = ''
      exec hyprland
    '';
  };

  # Environment Variables 
  environment.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
