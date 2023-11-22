{ config, lib, pkgs, ... }:

with lib;
{
  options = {
    gnome = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.gnome.enable) {
    services = {
      xserver = {
        enable = true;

        layout = "fi";
        xkbOptions = "eurosign:e";
        libinput.enable = true;

        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
      udev.packages = with pkgs; [
        gnome.gnome-settings-daemon
      ];
    };

    environment = {
      systemPackages = with pkgs; [
        gnome.adwaita-icon-theme
        gnome.dconf-editor
        gnome.gnome-tweaks
      ];
    };

    home-manager.users.patrik = {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          enable-hot-corners = true;
          clock-show-weekday = true;
          clock-show-seconds = true;
          cursor-size = 16;
          cursor-theme = "Adwaita";
          font-antialiasing = "grayscale";
          font-hinting = "slight";
          font-name = "Roboto 10";
          gtk-theme = "Gruvbox-Dark-BL";
          icon-theme = "Oomox-gruvbox-dark";
        };
        "org/gnome/desktop/calendar" = {
          show-weekdate = true;
        };
        "org/gnome/desktop/media-handling" = {
          automount = false;
          automount-open = false;
        };
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
        };
        "org/gnome/shell" = {
          favorite-apps = [
            "Alacritty.desktop"
            "anki.desktop"
            "bitwarden.desktop"
            "code.desktop"
            "discord.desktop"
            "firefox.desktop"
            "mpv.desktop"
            "org.gnome.Nautilus.desktop"
            "org.gnome.Settings.desktop"
            "de.haeckerfelix.Shortwave.desktop"
            "virtualbox.desktop"
          ];
          disable-user-extensions = false;
          enabled-extensions = [
            "trayIconsReloaded@selfmade.pl"
            "caffeine@patapon.info"
            "bluetooth-quick-connect@bjarosze.gmail.com"
            "user-theme@gnome-shell-extensions.gcampax.github.com"
          ];
        };
        "org/gnome/shell/extensions/user-theme" = {
          name = "Gruvbox-Dark-BL";
        };
      };

      home.packages = with pkgs.gnomeExtensions; [
        tray-icons-reloaded
        bluetooth-quick-connect
        caffeine
        user-themes
      ];
    };
  };
}