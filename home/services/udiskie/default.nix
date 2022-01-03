{ config, lib, pkgs, ... }:

{
  services.udiskie = {
    enable = true;
    tray = "always";
  };
}
