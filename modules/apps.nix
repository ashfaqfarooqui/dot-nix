{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [

    libreoffice
    evince
    okular
    copyq
  ];

  services.nextcloud-client.enable = true;
  services.nextcloud-client.startInBackground = true;
}
