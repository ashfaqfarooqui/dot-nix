{ config, pkgs, ... }:
let
  emacsOverlay = (import (builtins.fetchTarball {
    url =
      "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
  }));

  defaultPkgs = with pkgs; [
    filezilla
    zotero

    copyq

    #cli
    termite
    gopass
    gopass-jsonapi
    bat
    bottom
    curl
    du-dust
    dunst
    dmenu
    exa
    fd
    fzf
    gawk
    gnupg
    gnused
    keychain
    nix-zsh-completions
    #nnn
    ripgrep
    rsync
    tealdeer
    tree
    unzip
    xsv
    zsh-powerlevel10k
    stow
    htop
    xclip
    oh-my-zsh
    fzf-zsh
    direnv
    xdotool

 


    #fonts
    iosevka
    fira-code
    fira-code-symbols

    #PKM
    logseq
    obsidian

    # media
    mpv


    remmina
  ];

  emacsPkgs = with pkgs; [

    languagetool
    mu
    isync
    sqlite
    ispell
    aspell
    hunspell
    jetbrains-mono
    #nerdfonts
    ibm-plex
    overpass

    proselint
    sqlite
    graphviz
    coreutils
    clang
    #texlive.combined.scheme-full
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
  gnomePkgs = with pkgs.gnome3; [
    eog # image viewer
    evince # pdf reader
    gnome-calendar # calendar
    nautilus # file manager
  ];

  xmonadPkgs = with pkgs; [
    networkmanager_dmenu # networkmanager on dmenu
    networkmanagerapplet # networkmanager applet
    nitrogen # wallpaper manager
    xcape # keymaps modifier
    xorg.xkbcomp # keymaps modifier
    xorg.xmodmap # keymaps modifier
    xorg.xrandr # display manager (X Resize and Rotate protocol)
    multilockscreen
    xmobar
    trayer
  ];
  gitPkgs = with pkgs; [ git git-lfs gitAndTools.git-crypt pre-commit ];

  mailPkgs = with pkgs; [
    jdk11
    openjfx11
    davmail

  ];

  nixPkgs = with pkgs; [
    #    hydra-check
    nix-prefetch-github

    nur.repos.xe.comma
    #    nixpkgs-review
    #    nix-top
    niv
    nixpkgs-fmt
    cachix
    rnix-lsp
    nixfmt

  ];
  polybarPkgs = with pkgs; [
    siji
    font-awesome-ttf # awesome fonts
    material-design-icons # fonts with glyphs
  ];

in {
  nixpkgs.overlays =
    [ emacsOverlay (import ./overlays/logseq) (import ./overlays/discord) ];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball
      "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
  };
  home.file.".mbsyncrc".source = ../configs/mbsyncrc/.mbsyncrc;
  fonts.fontconfig.enable = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.extraOutputsToInstall = [ "man" ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ashfaqf";
  home.homeDirectory = "/home/ashfaqf";

  nixpkgs.config.allowUnfree = true;
  home.file.".config/nixpkgs/config.nix".text = ''
    { allowUnfree = true;
    }
  '';

  home.packages = defaultPkgs  ++ nixPkgs 
    ++ emacsPkgs ++ mailPkgs ;
  home.sessionVariables = {
    EDITOR = "emacsclient -c -a emacs";
    BROWSER = "firefox";
    QT_XCB_GL_INTEGRATION = "none";
  };
  imports = (import ./programs) ++ (import ./services);

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  programs = {
    bat.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };


    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type file --follow"; # FZF_DEFAULT_COMMAND
      defaultOptions = [ "--height 20%" ]; # FZF_DEFAULT_OPTS
      fileWidgetCommand = "fd --type file --follow"; # FZF_CTRL_T_COMMAND
    };
    htop = {
      enable = true;
      settings = {
        sort_direction = true;
        sort_key = "PERCENT_CPU";
      };
    };
    ssh.enable = true;
    vscode.enable = true;
  };

 

}
