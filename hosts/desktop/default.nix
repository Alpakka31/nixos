{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ] ++
            ( import ../../modules/desktops/virtualisation );

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];
  };

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        rocm-opencl-icd
        rocm-opencl-runtime
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
      driSupport = true;
      driSupport32Bit = true;
    };
    sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
    };
  };
  
  environment = {
    systemPackages = with pkgs; [
      simple-scan       # Scanning
    ];
  };

  # Enable GNOME
  #gnome.enable = true;
  
  # Enable Hyprland
  hyprland.enable = true;

  # Overlays
  nixpkgs.overlays = [
    (final: prev: {
      discord = prev.discord.overrideAttrs (
        _: { src = builtins.fetchTarball {
         url =
         "https://discord.com/api/download?platform=linux&format=tar.gz";
         sha256 =
         "1xjk77g9lj5b78c1w3fj42by9b483pkbfb41yzxrg4p36mnd2hkn";
        }; }
      );
    })
  ];
}