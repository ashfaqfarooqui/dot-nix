{ config, pkgs, libs, ... }: {
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  home.packages = with pkgs; [
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
}
