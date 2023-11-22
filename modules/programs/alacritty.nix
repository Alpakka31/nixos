{ pkgs, ... }:

{
  home-manager.users.patrik = {
    programs = {
      alacritty = {
        enable = true;
        settings = {
          font = {
            normal.family = "FiraCode Nerd Font";
            bold = { style = "Bold"; };
            size = 12;
          };
        };
      };
    };
  };
}