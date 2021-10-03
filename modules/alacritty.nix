{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    alacritty
    # libsixel
  ];
  xdg.configFile."alacritty/alacritty.yml".source = ../configs/alacritty/.config/alacritty;
}
