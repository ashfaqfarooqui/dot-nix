{ config, lib, pkgs, ... }:

{
  #TODO take inspiration from:
  #https://gvolpe.com/blog/xmonad-polybar-nixos/
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ../configs/xmonad/xmonad.hs;
    extraPackages = haskellPackages: [
      haskellPackages.xmonad-contrib
      haskellPackages.extra
    ];
  };
  xsession.enable = true;
  xsession.pointerCursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 32;

  };
  home.packages = [ pkgs.xmobar ];
  home.file.".xmobar/xmobarrc".source = ../configs/xmobar/xmobarrc;
  #  programs.xmobar.enable = true;
  #  programs.xmobar.extraConfig = "../configs/xmobar/xmobarrc";
  #
  #
  #
  #

  targets.genericLinux.enable = true;

}
