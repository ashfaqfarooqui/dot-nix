{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
#    nixos-shell
#    nix-du
#    nix-index
#    nix-prefetch
#    nix-prefetch-git
  ];
}
