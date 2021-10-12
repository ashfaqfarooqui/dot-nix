{ config, pkgs, libs, ... }: {
  home.packages = with pkgs;
  [

    #    metals
    #    sbt
    #    scala
    #    rust-analyzer
    libreoffice
    texlive.combined.scheme-full
  ];

  services.lorri = {
    enable = true;
  };
}
