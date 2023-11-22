{ pkgs, ... }:

{
    users.groups = {
        vboxusers.members = [ "root" "patrik" ];
        kvm.members = [ "root" "patrik" ];
    };

    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;

    environment = {
        systemPackages = with pkgs; [
            virtualboxWithExtpack # VirtualBox with Extension Pack included
        ];
    };
}