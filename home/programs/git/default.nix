{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Ashfaq Farooqui";
    userEmail = "ashfaq@ashfaqfarooqui.me";
    signing = {
      signByDefault = true;
      key = "7A804BCB51DE2D88";

    };
    ignores = [
      "*.bloop"
      "*.bsp"
      "*.metals"
      "*.metals.sbt"
      "*metals.sbt"
      "*.direnv"
      "*.envrc" # there is lorri, nix-direnv & simple direnv; let people decide
      "*hie.yaml" # ghcide files
      "*.mill-version" # used by metals
      "*.jvmopts" # should be local to every project
    ];
  };
}
