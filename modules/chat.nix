{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [ discord slack signal-desktop zoom-us teams ];
}
