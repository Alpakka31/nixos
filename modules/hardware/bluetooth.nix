{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # Comment this in the first time you want to connect to AirPods.
  # In order to connect, you have to press the button on the back
  # of the AirPods case.
  # `breder` is only needed for the initial connection of the AirPods.
  # Afterwards the mode can be relaxed to `dual` (the default) again.
  #
  # hardware.bluetooth.settings = { General = { ControllerMode = "bredr"; }; };

  #systemd.services.bluetooth.serviceConfig.ExecStart = [
  #  ""
  #  "${pkgs.bluez}/libexec/bluetooth/bluetoothd --noplugin=sap,avrcp"
  #];
}