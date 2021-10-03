{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ iosevka fira-code fira-code-symbols ];
  fonts.fontconfig.enable = true;
}
