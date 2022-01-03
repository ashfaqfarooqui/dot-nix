{ config, lib, pkgs, ... }:
let
  polybarOpts = ''
    ${pkgs.nitrogen}/bin/nitrogen --restore &
    ${pkgs.pasystray}/bin/pasystray &
    ${pkgs.blueman}/bin/blueman-applet &
    ${pkgs.gnome3.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator &
  '';
in {
  xsession = {
    enable = true;

    pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 64;
    };

    initExtra = polybarOpts;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.extra
        haskellPackages.dbus
        haskellPackages.monad-logger
      ];
    };
  };
  xresources.properties = {
    "Xft.dpi" = 180;
    "Xft.autohint" = 0;
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = 1;
    "Xft.antialias" = 1;
    "Xft.rgba" = "rgb";
    "Xcursor*theme" = "Vanilla-DMZ-AA";
    "Xcursor*size" = 24;
  };

  home.file.".xmobar/xmobarrc".source = ../../../configs/xmobar/xmobarrc;
}
