{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    filezilla
    rawtherapee
    jetbrains.idea-community
    brave
    firefox
    graphviz
    nextcloud-client
    okular
    evince
    openssh
    zoom
    zotero

  ];

  programs.vscode = {
    enable = true;

  };
}
