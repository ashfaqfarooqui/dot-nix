{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    termite
    gopass
    gopass-jsonapi
    bat
    bottom
    coreutils
    curl
    du-dust
    dunst
    dmenu
    exa
    fd
    ffsend
    fzf
    gawk
    gnupg
    gnused
    gnutls
    keychain
    mosh
    nix-zsh-completions
    nixfmt
    nnn
    ripgrep
    rsync
    socat
    tealdeer
    tmux
    tree
    unzip
    xsv
    zsh
    zsh-powerlevel10k
    stow
    htop
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = false;
    # enableNixDirenvIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    #  environment.pathsToLink = [ "/share/zsh" ];
    #enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    history.ignorePatterns = [ "rm *" "pkill *" "ls *" ];
    oh-my-zsh = {
      enable = true;
      plugins = [ "sudo" ];
    };
    initExtraFirst = ''
      # Emacs tramp mode compatibility
      [[ $TERM == "tramp" ]] && unsetopt zle && PS1='$ ' && return

      # Hook direnv
      emulate zsh -c "$(direnv export zsh)"

      # Enable direnv
      emulate zsh -c "$(direnv hook zsh)"
    '';
    # initExtraBeforeCompInit = builtins.readFile ../configs/zsh/.zshrc;

    #    plugins = [
    #      {
    #        # will source zsh-autosuggestions.plugin.zsh
    #        name = "zsh-syntax-highlighting";
    #        src = pkgs.fetchFromGitHub {
    #          owner = "zsh-users";
    #          repo = "zsh-syntax-highlighting";
    #          rev = "v0.7.1";
    #          sha256 = "932e29a0c75411cb618f02995b66c0a4a25699bc";
    #        };
    #      }
    #      {
    #        name = "enhancd";
    #        file = "init.sh";
    #        src = pkgs.fetchFromGitHub {
    #          owner = "b4b4r07";
    #          repo = "enhancd";
    #          rev = "v2.2.4";
    #          sha256 = "100b809043a04010ae836f25e4bbab07089e41ab";
    #        };
    #      }
    #    ];
    #
  };

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  xdg.configFile."git/config".source = ../configs/git/.gitconfig;
  # xdg.configFile."dircolors".source = pkgs.LS_COLORS.outPath + "/LS_COLORS";

  home.file.".mbsyncrc".source = ../configs/mbsyncrc/.mbsyncrc;

  programs.termite = {
    enable = true;
    enableVteIntegration = true;
    allowBold = true;
    # backgroundColor = "rgba()";
    colorsExtra = ''

      # black
      color0  = #1e2320
      color8  = #709080

      # red
      color1  = #705050
      color9  = #dca3a3

      # green
      color2  = #60b48a
      color10 = #c3bf9f

      # yellow
      color3  = #dfaf8f
      color11 = #f0dfaf

      # blue
      color4  = #506070
      color12 = #94bff3

      # magenta
      color5  = #dc8cc3
      color13 = #ec93d3

      # cyan
      color6  = #8cd0d3
      color14 = #93e0e3

      # white
      color7  = #dcdccc
      color15 = #ffffff

    '';
    cursorBlink = "system";
    cursorColor = "#ffffff";
    cursorForegroundColor = "#ffffff";
    cursorShape = "block";
    font = "Iosevka 13";
    foregroundBoldColor = "#ffffff";

  };

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = true;
    settings = {

    };
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -c -a emacs";
    BROWSER = "brave";
    QT_XCB_GL_INTEGRATION = "none";
  };
}
