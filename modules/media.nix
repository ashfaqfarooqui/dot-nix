{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [ vlc inkscape gimp mpv shotwell ];
}
