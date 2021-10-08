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
    zotero
    libreoffice
    evince
    okular
    insync-v3
    copyq

  ];

  services.nextcloud-client.enable = true;
  services.nextcloud-client.startInBackground = true;
  programs.vscode = {
    enable = true;

  };

 programs = {
    rofi = {
      enable = true;
    location = "center";
    terminal = "termite";
      width = 50;
      lines = 5;
      borderWidth = 0;
      rowHeight = 1;
      padding = 5;
      font = "Iosevka 16";
      separator = "solid";
      colors = {
        window = {
          background = "#000000";
          border = "#DD8500";
          separator = "#DD8500";
        };
        rows = {
          normal = {
            background = "#000000";
            foreground = "#DD8500";
            backgroundAlt = "#000000";
            highlight = {
              background = "#DD8500";
              foreground = "#ffffff";
            };
          };
        };
      };
    };
  };
}
