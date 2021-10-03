{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [ git git-lfs gitAndTools.git-crypt pre-commit ];
  home.file.".config/git/ignore".text = ''
    tags
    result
  '';

  programs.git = {
    enable = true;
    userName = "Ashfaq Farooqui";
    userEmail = "ashfaq@ashfaqfarooqui.me";
  };

}
