{ config, pkgs, libs, ... }:
{


  programs.home-manager.enable = true;
  programs.man.enable = true;
  home.extraOutputsToInstall = [ "man" ];
  #users.users.shell = "zsh";

  # home.sessionVariables = {
  #   LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  # };
}
