{ config, pkgs, libs, ... }: {
  home.packages = with pkgs;
    [

      #    metals
      #    sbt
      #    scala
      #    rust-analyzer
      libreoffice
    ];

  programs.texlive = {
    enable = true;

  };
}
