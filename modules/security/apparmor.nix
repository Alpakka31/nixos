{ pkgs, ... }:

{
  security = {
    apparmor = {
      enable = true;
      packages = with pkgs; [
        apparmor-profiles
      ];
    };
    pam = {
      services = {
        login = {
          enableGnomeKeyring = true;
        };
      };
    };
  };

  services = {
    dbus = {
      apparmor = "enabled";
    };
    openssh = {
      settings = {
        passwordAuthentication = false;
        permitRootLogin = "no";
      };
    };
  };
}