{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    filezilla
    rawtherapee
    #jetbrains.idea-community
    firefox
    graphviz
    nextcloud-client
    okular
    evince
    openssh
    zotero
    libreoffice
    evince
    okular
    #insync-v3
    copyq

  ];

  services.nextcloud-client.enable = true;
  services.nextcloud-client.startInBackground = true;
  programs.vscode = {
    enable = true;

  };
}
