{ config, lib, pkgs, ... }:

{
  programs.termite = {
    enable = true;
    enableVteIntegration = true;
    allowBold = true;
    # backgroundColor = "rgba()";
    colorsExtra = ''

      # black
      color0  = #1e2320
      color8  = #709080

      # red
      color1  = #705050
      color9  = #dca3a3

      # green
      color2  = #60b48a
      color10 = #c3bf9f

      # yellow
      color3  = #dfaf8f
      color11 = #f0dfaf

      # blue
      color4  = #506070
      color12 = #94bff3

      # magenta
      color5  = #dc8cc3
      color13 = #ec93d3

      # cyan
      color6  = #8cd0d3
      color14 = #93e0e3

      # white
      color7  = #dcdccc
      color15 = #ffffff

    '';
    cursorBlink = "system";
    cursorColor = "#ffffff";
    cursorForegroundColor = "#ffffff";
    cursorShape = "block";
    font = "Iosevka 13";
    foregroundBoldColor = "#ffffff";

  };

}
