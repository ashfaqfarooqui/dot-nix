{ config, pkgs, ... }:
let
  emacsOverlay = (import (builtins.fetchTarball {
    url =
      "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
  }));
  rosOverlay = builtins.fetchTarball {
    url =
      "https://github.com/lopsided98/nix-ros-overlay/archive/6ed3fe9f34a9b44dc306bcc668ea70d0685d86be.tar.gz";
  };

in {

  nixpkgs.overlays = [ emacsOverlay (import (rosOverlay + "/overlay.nix")) ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ashfaqf";
  home.homeDirectory = "/home/ashfaqf";
  nixpkgs.config.allowUnfree = true;
  home.file.".config/nixpkgs/config.nix".text = ''
    { allowUnfree = true;
    }
  '';

  home.packages = [ ];

  imports = [

    ./modules/cli.nix
    ./modules/emacs.nix
    ./modules/git.nix
    ./modules/home-manager.nix
    ./modules/languages.nix
    ./modules/nix-utilities.nix
    ./modules/chat.nix
    ./modules/nixos-desktop.nix
    ./modules/xmonad.nix
    ./modules/fonts.nix
    ./modules/media.nix
    ./modules/davmail.nix
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
