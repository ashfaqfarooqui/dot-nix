{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [
    obsidian

    languagetool
    mu
    isync
    sqlite
    ispell
    aspell
    hunspell
    jetbrains-mono
    nerdfonts
    ibm-plex
    overpass

  proselint
    sqlite
    graphviz
    coreutils
    clang
    texlive.combined.scheme-full
    vdirsyncer
    khal

    (makeDesktopItem {
      name = "org-protocol";
      exec = "emacsclient %u";
      comment = "Org Protocol";
      desktopName = "org-protocol";
      type = "Application";
      mimeType = "x-scheme-handler/org-protocol";
    })
  ];
  services.emacs.enable = true;

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = epkgs: [ epkgs.emacsql-sqlite epkgs.pdf-tools epkgs.vterm ];
  };

  #home.file.".doom.d/init.el".source = ../configs/doom/.doom.d/init.el;

  #  home.file.".doom.d/config.org".source = ../configs/doom/.doom.d/config.org;
  #  home.file.".doom.d/elfeed.org".source = ../configs/doom/.doom.d/elfeed.org;
  #  home.file.".doom.d/packages.el".source = ../configs/doom/.doom.d/packages.el;
  home.file.".doom.d/".source =
    config.lib.file.mkOutOfStoreSymlink ../configs/doom/.doom.d;
}
