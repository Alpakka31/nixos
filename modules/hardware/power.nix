{ config, lib, pkgs, ... }:

# TODO
with lib;
{
  config = lib.mkIf ( config.laptop.enable ) {
    services = {
      tlp.enable = true;                          # Power Efficiency
      auto-cpufreq.enable = true;
    };
  };
}