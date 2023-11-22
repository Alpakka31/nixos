{ config, lib, pkgs, inputs, ... }:

{
  imports = ( import ../modules/desktops ++
              import ../modules/hardware ++
              import ../modules/programs ++
              import ../modules/security ++
              import ../modules/shell ++
              import ../modules/theming );

  users.users.patrik = {
    isNormalUser = true;
    description = "Patrik Nyström";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "scanner" "lp" ];
  };

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "fi";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  fonts = {
     fonts = with pkgs; [
       noto-fonts
       noto-fonts-cjk
       noto-fonts-emoji
       iosevka
       inter
       font-awesome
       source-han-sans
       source-han-sans-japanese
       source-han-serif-japanese
       roboto
       (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Hack" "SourceCodePro"  ]; })
     ];
     enableDefaultFonts = true;
     fontDir.enable = true;
     fontconfig = {
       enable = true;
       antialias = true;
       defaultFonts = {
         serif = [ "Roboto Slab" ];
         sansSerif = [ "Inter" ];
         monospace = [ "FiraCode Nerd Font Mono" ];
         emoji = [ "Noto Color Emoji" ];
       };
     };
  };

  environment.systemPackages = with pkgs; [
     vim
     wget
     curl
     unrar
     unzip
     p7zip
     clang_16
     gnumake
     git
     sox
     ripgrep
     btop
     ffmpeg
     vulkan-loader
     vulkan-tools
     gparted
     dosfstools
     mtools
     ntfs3g
     btrfs-progs
  ];

  programs = {
    dconf.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    fstrim = {
      enable = true;
    };
    gvfs = {
      enable = true;
    };
    printing = {
      enable = true;
    };
    openssh = {
      enable = false;
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
  };
  nixpkgs.config.allowUnfree = true;
  
  system = {
    stateVersion = "23.05";
  };
}
