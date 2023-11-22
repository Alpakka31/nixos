{ pkgs, ... }:

{
  home-manager.users.patrik = {
    home = {
      pointerCursor = {                     # System-Wide Cursor
        gtk.enable = true;
        name = "Adwaita";
        size = 16;
        package = pkgs.gnome.gnome-themes-extra;
      };
    };

    gtk = {                                 # Theming
      enable = true;
      theme = {
        name = "Gruvbox-Dark-BL";
        package = pkgs.gruvbox-gtk-theme;
      };
      iconTheme = {
        name = "Oomox-gruvbox-dark";
        package = pkgs.gruvbox-dark-icons-gtk;
      };
      font = {
        name = "Roboto";
        size = 10;
      };
    };
  };
}