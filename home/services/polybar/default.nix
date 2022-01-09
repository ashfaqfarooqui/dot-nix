{ config, lib, pkgs, ... }:
let

  mypolybar = pkgs.polybar.override {
    alsaSupport = false;
    githubSupport = false;
    mpdSupport = false;
    pulseSupport = false;
  };
  monitorScript = pkgs.callPackage ./scripts/monitors.nix { };
  xmonad = ''
    [module/xmonad]
    type = custom/script
    exec = ${pkgs.xmonad-log}/bin/xmonad-log
    tail = true
  '';

  bar = pkgs.callPackage ./bar.nix { };
  bars = builtins.readFile ./bars.ini;
  colors = builtins.readFile ./colors.ini;
  mods1 = builtins.readFile ./modules.ini;

  mods2 = builtins.readFile ./user_modules.ini;

  customMods = bar + xmonad;

in {

  services.polybar = {
    enable = true;
    config = ./config.ini;
    package = mypolybar;
    extraConfig = bars + colors + mods1 + mods2 + customMods;
    script = "polybar top &";
  };
}
