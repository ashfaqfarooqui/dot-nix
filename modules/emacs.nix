{ config, pkgs, libs, ... }: {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    }))
  ];

  home.packages = with pkgs; [
    languagetool
    mu
    isync
    sqlite
    ispell
    hunspell
    jetbrains-mono
    nerdfonts
    ibm-plex
    overpass

    clang
    coreutils

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
    package = pkgs.emacsPgtkGcc;
    extraPackages = epkgs: [ epkgs.emacsql-sqlite epkgs.pdf-tools epkgs.vterm];
  };

  #home.file.".doom.d/init.el".source = ../configs/doom/.doom.d/init.el;

#  home.file.".doom.d/config.org".source = ../configs/doom/.doom.d/config.org;
#  home.file.".doom.d/elfeed.org".source = ../configs/doom/.doom.d/elfeed.org;
#  home.file.".doom.d/packages.el".source = ../configs/doom/.doom.d/packages.el;
home.file.".doom.d/".source = config.lib.file.mkOutOfStoreSymlink ../configs/doom/.doom.d;
}
