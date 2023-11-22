{ pkgs, inputs, home-manager, ... }:

{
    home = {
      stateVersion = "23.05";
      packages = with pkgs; [
        neofetch
        flameshot
        bitwarden
        kdenlive
        mediainfo
        glaxnimate
        audacity
        gimp
        discord
        mpv
        anki
        virtualboxWithExtpack
        shortwave
        vscode
        rustup
        nodejs_20
        yarn
        alacritty
      ];
    };

    programs = {
      home-manager.enable = true;
      
      firefox = {
        enable = true;
        package = pkgs.firefox.override {
          cfg = {
            enableGnomeExtensions = true;
          };
        };
      };

      mpv = {
        enable = true;
      };

      vscode = {
        enable = true;
        userSettings = {
          "workbench.iconTheme" = "eq-material-theme-icons";
          "explorer.confirmDragAndDrop" = false;
          "explorer.confirmDelete" = false;
          "workbench.colorTheme" = "Gruvbox Dark Hard";
          "redhat.telemetry.enabled" = false;
          "editor.formatOnSave" = true;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.fontFamily" = "FiraCode Nerd Font, monospace";
          "editor.fontSize" = 16;
          "editor.fontLigatures" = true;
          "terminal.integrated.fontSize" = 14;
        };
      };
    };
}