{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
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
    zsh
    zsh-powerlevel10k
    stow
    htop
    xclip
    oh-my-zsh
    fzf-zsh
    direnv
    xdotool
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    #  environment.pathsToLink = [ "/share/zsh" ];
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    history.ignorePatterns = [ "rm *" "pkill *" "ls *" ];
    oh-my-zsh = {
      enable = true;
      plugins = [ "sudo" "dirhistory" ];
    };
initExtraBeforeCompInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

 initExtra = "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh";
    initExtraFirst = ''
      # Emacs tramp mode compatibility
      [[ $TERM == "tramp" ]] && unsetopt zle && PS1='$ ' && return

      # Hook direnv
      emulate zsh -c "$(direnv export zsh)"

      # Enable direnv
      emulate zsh -c "$(direnv hook zsh)"
    '';
    # initExtraBeforeCompInit = builtins.readFile ../configs/zsh/.zshrc;
    plugins = [

{
      name = "zsh-nix-shell";
      file = "nix-shell.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "chisui";
        repo = "zsh-nix-shell";
        rev = "v0.4.0";
        sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
      };
    }
    
     ];

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

  home.sessionVariables = {
    EDITOR = "emacsclient -c -a emacs";
    BROWSER = "firefox";
    QT_XCB_GL_INTEGRATION = "none";
  };

  services.gpg-agent = {
    enable = true;
    grabKeyboardAndMouse = false;
    enableSshSupport = true;
    pinentryFlavor = "curses";

  };

  programs = {
    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
    feh = {
      enable = true;

    };
    firefox = { enable = true; };
    gpg = {
      enable = true;

    };
  };

}
