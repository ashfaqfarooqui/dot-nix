{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    #enable = true;
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
    initExtraBeforeCompInit =
      "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

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

}
